function [net, info, expdir] = finetune_cnn(varargin)

%% Define options
run(fullfile(fileparts(mfilename('fullpath')), ...
  'matconvnet-1.0-beta23', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-stl.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

opts.train.gpus = [];



%% update model

net = update_model();

%% TODO: Implement getIMDB function below

if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'birds', 'ships', 'horses', 'cars'};
splits = {'train', 'test'};

%% TODO: Implement your loop here, to create the data structure described in the assignment
%% Use train.mat and test.mat we provided from STL-10 to fill in necessary data members for training below
%% You will need to, in a loop function,  1) read the image, 2) resize the image to (32,32,3), 3) read the label of that image
% Define parameters.
mat_file = {'data/train.mat', 'data/test.mat'};
h = 96;
w = 96;
c = 3;
labels_i = [1 2 9 7 3];
train_image_per_class = 500;
test_image_per_class = 800;
% Compute the total number of images including the train and test sets.
tot_images = train_image_per_class * size(labels_i, 2) + test_image_per_class * size(labels_i, 2);
% Initialize the final matrices.
data = zeros(tot_images, h * w * c, 'single'); 
labels = zeros(tot_images, 1, 'single');
sets = zeros(tot_images, 1);
% Loop per mat_file.
image_per_class = 0;
for mat_i = 1:2        
    last_image_per_class = image_per_class;
    if mat_i == 1        
        image_per_class = train_image_per_class;
    else        
        image_per_class = test_image_per_class;
    end            
    load(mat_file{mat_i});
    % Concatenate the images with their labels for convenience.
    tmp = [X y];
    % Compute the number of images to read.
    images = image_per_class * size(labels_i, 2);
    % Initialize tmp matrices.
    data_tmp = zeros(images, size(X, 2), 'single');
    labels_tmp = zeros(images, 1, 'single');
    set_tmp = mat_i * ones(images, 1);
    % Loop per classes.
    for i_class = 1:size(labels_i,2)
        % Find the indices of the images of the class.
        indices = find(tmp(:, size(X, 2) + 1) == labels_i(i_class));
        % Store the corresponding images of the class.
        image_range = (i_class - 1) * image_per_class + 1: i_class * image_per_class;
        data_tmp(image_range, :) = X(indices, :);        
        labels_tmp(image_range, :) = i_class;
    end
    % Store the tmp matrices into the final matrices.
    tot_image_range = last_image_per_class * size(labels_i, 2) + 1: last_image_per_class * size(labels_i, 2) + images;
    data(tot_image_range, :)  = data_tmp(:, :);
    labels(tot_image_range, :) = labels_tmp(:, :);
    sets(tot_image_range, :) = set_tmp(:, :);    
end
% Reshape data.
data = reshape(data, size(data, 1), h, w, c);
data = permute(data, [2, 3, 4, 1]);
% Resize images.
new_data = zeros(32, 32, 3, tot_images, 'single'); 
for image_i = 1:size(data, 4)
    new_data(:, :, :, image_i) = imresize(squeeze(data(:, :, :, image_i)), [32 32]);
end
data = new_data;

%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = labels' ;
imdb.images.set = sets';
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.labels));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
