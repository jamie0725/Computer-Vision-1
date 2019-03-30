clear all
close all

CHECKPOINT=false;
% CHECKPOINT=true;

addpath('./')

% load fisheriris
% inds = ~strcmp(species,'setosa');
% X = meas(inds,3:4);
% y = species(inds);

data=twospirals();
features = data(:,1:2);
features = reshape(features, 2,1000,1, []);
% train_labels = data
train_features=features(:,1:800,:);
classifiers = train_classifiers(train_features);

% Load the whole set of evaluation images.


test_features=features(:,800:1000,:);
[inds, map] = evaluateSVM(test_features, classifiers);
disp('finish evaluation')

fprintf('%f', map);

exit