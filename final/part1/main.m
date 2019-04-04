function main(sm_i, cs_i, nc_i, checkpoint)
%MAIN Main file.
%   sm_i: index for sampling method, 1 for keypoint and 2 for dense.
%   cs_i: index for colorspace, 1 for greyscale, 2 for RGB and 3 for ORGB.
%   nc_i: index for feature size, 1 for 400, 2 for 1000, 3 for 4000.
%   checkpoint: flag for reading checkpoint.

CHECKPOINT=checkpoint;

addpath('./')
run('./vlfeat/toolbox/vl_setup');

% Load the whole set of training images.
[train_images_tot, train_labels_tot, class_names] = load_images('train5.mat');
% Create parameters.
feature_size = [400 1000 4000];
sample_method = {'key', 'dense'};
colorspace = {'grey', 'rgb', 'orgb'};
% Prepare the training features, labels and vocabulary for training the SVM
% classifier and for later evaluation.
sm = sample_method{sm_i};
cs = colorspace{cs_i};
nc = feature_size(nc_i);

log_file = fopen(sprintf('%s/log/%d_%s_%s_log.txt', '.', nc, sm, cs), 'w');


if CHECKPOINT
    load(sprintf('%s/data/%d_%s_%s_data_f.mat', '.', nc, sm, cs), 'train_features')
    load(sprintf('%s/data/%d_%s_%s_data_l.mat', '.', nc, sm, cs), 'train_labels');
    disp('finish loading trainset')
else
    [train_features, train_labels, vocabulary]= prepare_training(train_images_tot, train_labels_tot, nc, sm, cs);
    disp('finish loading trainset')
    save(sprintf('%s/data/%d_%s_%s_data_f.mat', '.', nc, sm, cs), 'train_features');
    save(sprintf('%s/data/%d_%s_%s_data_l.mat', '.', nc, sm, cs), 'train_labels');
    disp('finish saving trainset')
end



if CHECKPOINT
    
    load(sprintf('%s/data/%d_%s_%s_classifiers.mat', '.', nc, sm, cs), 'classifiers');
else
    classifiers = train_classifiers(train_features);
    disp('finish training')
    save(sprintf('%s/data/%d_%s_%s_classifiers.mat', '.', nc, sm, cs), 'classifiers');
    disp('finish saving training model')
end



% Load the whole set of evaluation images.
[test_images_tot, test_labels_tot, ~] = load_images('test5.mat');

disp('finish loading testset')

if CHECKPOINT
    load(sprintf('%s/data/%d_%s_%s_test_data_f.mat', '.', nc, sm, cs), 'test_features');
    load(sprintf('%s/data/%d_%s_%s_test_data_l.mat', '.', nc, sm, cs), 'test_labels');
else
    [test_features, test_labels] = prepare_evaluation(test_images_tot, test_labels_tot, vocabulary, sm, cs);
    save(sprintf('%s/data/%d_%s_%s_test_data_f.mat', '.', nc, sm, cs), 'test_features');
    save(sprintf('%s/data/%d_%s_%s_test_data_l.mat', '.', nc, sm, cs), 'test_labels');
end

[inds, map, APs, accuracy_li] = evaluateSVM(test_features, classifiers);
disp('finish evaluation')
fprintf(log_file, '%.2f\n', map);
fprintf(log_file, "APs:\n");
for i = 1:size(APs,1)
    fprintf(log_file, "%.2f\n", APs(i,1));
    fprintf(log_file, "Accuracy:\n")
for i = 1:size(accuracy_li,1)
    fprintf(log_file, "%.2f\n", accuracy_li{i});
end

disp(sprintf('%f', map));

for i = 1:size(inds,1)
    ind=inds{i};
    length=size(ind,1);
    front_ind=ind(1:5);
    end_ind=ind(length-5:length);
    for j = 1:5
        tmp_img = squeeze(test_images_tot(front_ind(j),:,:,:));
        imwrite(tmp_img, sprintf('%s/images/%d_%s_%s_img_class_%d_front_%d.png', '.', nc, sm, cs, i, j));
        tmp_img = squeeze(test_images_tot(end_ind(j),:,:,:));
        imwrite(tmp_img, sprintf('%s/images/%d_%s_%s_img_class_%d_end_%d.png', '.', nc, sm, cs, i, j));
    end
end
fclose(log_file);

exit
    
end
