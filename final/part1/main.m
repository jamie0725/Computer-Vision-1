clear all
close all

% Load the whole set of training images.
[train_images_tot, train_labels_tot, class_names] = load_images('train5.mat');
% Create parameters.
feature_size = [400 1000 4000];
sample_method = {'key', 'dense'};
colorspace = {'grey', 'rgb', 'orgb'};
% Prepare the training features, labels and vocabulary for training the SVM
% classifier and for later evaluation.
[train_feature, train_labels, vocabulary]= prepare_training(train_images_tot, train_labels_tot, 100, sample_method{1}, colorspace{2});

% Load the whole set of evaluation images.
[test_images, test_labels, ~] = load_images('test5.mat');