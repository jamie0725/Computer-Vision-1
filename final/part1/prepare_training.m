function [train_features, train_labels, vocabulary] = prepare_training(train_images_tot, train_labels_tot, feature_size, sample_method, colorspace)
%PREPARE_TRAINING Prepare the train features and their corresponding labels
%for the SVM classifier.
%   train_images_tot: The whole set of training images.
%   train_labels_tot: The whole set of traninig labels.
%   feature_size: Number of clusters/features.
%   sample_method: 'dense' or 'key'.
%   colorspace: 'rgb', 'orgb', 'grey'.
%   train_features: The encoded visual features per image per class
%   [num_class, dict_image_size_per_class, feature_size].
%   train_classes: labels per classes.
%   vocabulary: coordinates of the centroids (visual words) [feature_size, (128 for grayscale-SIFT, 128 * 3 for RGB-SIFT and opponent-SIFT)].
% Pick the labels for the chosen classes.
train_labels = unique(train_labels_tot);
num_class = numel(train_labels);
% Assume each class has equivalent number of images.
image_per_class = numel(train_labels_tot) / num_class;
vocab_image_size_per_class = round(image_per_class * 0.25);
dict_image_size_per_class = image_per_class - vocab_image_size_per_class;
train_features = zeros(num_class, dict_image_size_per_class, feature_size);
[~, w, h, c] = size(train_images_tot);
vocab_images = zeros(vocab_image_size_per_class * num_class, w, h, c, 'uint8');
dict_images = zeros(dict_image_size_per_class * num_class, w, h, c, 'uint8');
for i_class = 1:num_class
    % Randomly divide the images in each class for building the vocabulary and
    % for encoding features (training the SVM classifier).
    vocab_image_inds = randperm(image_per_class, vocab_image_size_per_class);
    dict_image_inds = setdiff(1:image_per_class, vocab_image_inds) + (i_class - 1) * num_class;
    vocab_image_inds = vocab_image_inds + (i_class - 1) * num_class;
    vocab_images(1 + (i_class - 1) * vocab_image_size_per_class : i_class * vocab_image_size_per_class, :, :, :) = train_images_tot(vocab_image_inds, :, :, :);
    dict_images(1 + (i_class - 1) * dict_image_size_per_class : i_class * dict_image_size_per_class, :, :, :) = train_images_tot(dict_image_inds, :, :, :);
end
% Build the vocabulary and encode the features into visual dictionaries per
% image.
vocabulary = build_vocabulary(vocab_images, feature_size, sample_method, colorspace);
visual_dict = encode_features(vocabulary, dict_images, sample_method, colorspace);
% Summarize the visual features into a tensor for further training.
for i_class = 1:num_class
    train_features(i_class, :, :) = visual_dict(1 + (i_class - 1) * dict_image_size_per_class: i_class * dict_image_size_per_class, :);
end
end