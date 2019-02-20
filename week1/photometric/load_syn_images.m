function [ image_stack, scriptV ] = load_syn_images( image_dir, channel, slice )
%LOAD_SYN_IMAGES read from directory image_dir all files with extension png
%   image_dir: path to the image directory
%   nchannel: the image channel to be loaded, default = 1
%
%   image_stack: all images stacked along the 3rd channel
%   scriptV: light directions

files = dir(fullfile(image_dir, '*.png'));
nfiles = length(files);

if nargin == 1
    channel = 1;
    slice = 1;
end
if nargin == 2
    slice =1;
end
image_stack = 0;
V = 0;
Z = 0.5;

n_dim = idivide(int32(nfiles-1), int32(slice), 'floor')+1
for i = 1:slice:nfiles

    % read input image
    im = imread(fullfile(image_dir, files(i).name));
    im = im(:, :, channel);
    
    % stack at third dimension
    if image_stack == 0
        [h, w] = size(im);
        fprintf('Image size (HxW): %dx%d\n', h, w);
        image_stack = zeros(h, w, n_dim, 'uint8');
        V = zeros(n_dim, 3, 'double');
    end
    
    image_stack(:, :, i) = im;
    
    % read light direction from image name
    name = files(i).name(8:end);
    m = strfind(name,'_')-1;
    X = str2double(name(1:m));
    n = strfind(name,'.png')-1;
    Y = str2double(name(m+2:n));
    V(i, :) = [-X, Y, Z];
end

% normalization
min_val = double(min(image_stack(:)));
max_val = double(max(image_stack(:)));
image_stack = (double(image_stack) - min_val) / (max_val - min_val);

normV = sqrt(sum(V.^2, 2));
scriptV = bsxfun(@rdivide, V, normV);

end