function [images, labels, class_names] = load_images(mat_file)
%LOAD_IMAGES Load the images from the .mat file and reshape.
%   mat_file: .mat file to read from.
%   images: Loaded images reshaped.
%   labels: Labels for the images.
%   class_names: Class names for the labels.
load(mat_file, 'images', 'labels', 'class_names');
images = reshape(images,size(images, 1),96,96,3);
end