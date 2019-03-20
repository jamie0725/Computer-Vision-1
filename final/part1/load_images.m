function [images labels label_names] = load_images(mat_file)
load(mat_file, 'X', 'y', 'class_names');
images = reshape(X,size(X, 1),96,96,3);
labels = y;
label_names = class_names;
end