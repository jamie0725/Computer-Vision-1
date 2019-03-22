function [test_features, test_labels] = prepare_evaluation(test_images_tot, test_labels_tot, vocabulary, sample_method, colorspace)
%PREPARE_EVALUATION Prepare the test features and their corresponding labels
%for the SVM classifier.
%   test_images_tot: The whole set of test images.
%   test_labels_tot: The whole set of test labels.
%   vocabulary: coordinates of the centroids (visual words) [feature_size, (128 for grayscale-SIFT, 128 * 3 for RGB-SIFT and opponent-SIFT)].
%   sample_method: 'dense' or 'key'.
%   colorspace: 'rgb', 'orgb', 'grey'.
%   test_features: The encoded visual features per image per class
%   [num_class, dict_image_size_per_class, feature_size].
%   test_labels: Labels per classes.
test_labels = unique(test_labels_tot);
num_class = numel(test_labels);
image_per_class = numel(test_labels_tot) / num_class;
visual_dict = encode_features(vocabulary, test_images_tot, sample_method, colorspace);
% Summarize the visual features into a tensor for further training.
test_features = reshape(visual_dict, image_per_class, num_class, []);
test_features = permute(test_features, [2 1 3]);
end