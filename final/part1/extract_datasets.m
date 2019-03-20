clear all
close all

classes = [1 2 9 7 3];
load('stl10_matlab/train.mat');
class_names = class_names(classes);
tmp = [X y];
images = zeros(500 * 5, size(X, 2));
labels = zeros(500 * 5, 1);
for i_class = 1:size(classes,2)
    indices = find(tmp(:, size(X, 2) + 1) == classes(i_class));
    images((i_class - 1) * 500 + 1: i_class * 500, :) = X(indices, :);
    labels((i_class - 1) * 500 + 1: i_class * 500, :) = y(indices, :);
end

save('train5.mat', 'images', 'labels', 'class_names');

clear all
classes = [1 2 9 7 3];
load('stl10_matlab/test.mat');
class_names = class_names(classes);
tmp = [X y];
images = zeros(800 * 5, size(X, 2));
labels = zeros(800 * 5, 1);
for i_class = 1:size(classes,2)
    indices = find(tmp(:, size(X, 2) + 1) == classes(i_class));
    images((i_class - 1) * 800 + 1: i_class * 800, :) = X(indices, :);
    labels((i_class - 1) * 800 + 1: i_class * 800, :) = y(indices, :);
end

save('test5.mat', 'images', 'labels', 'class_names');