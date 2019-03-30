function visual_dict = encode_features(vocabulary, images, sample_method, colorspace)
%ENCODE_FEATURES Extract features of the chosen subset of images and assign their corresponding visual dictionaries.
%   vocabulary: coordinates of the centroids (visual words) [feature_size, (128 for grayscale-SIFT, 128 * 3 for RGB-SIFT and opponent-SIFT)].
%   images: subset of images [#images, w, h, channels].
%   sample_method: 'dense' or 'key'.
%   colorspace: 'rgb', 'orgb', 'grey'.
%   visual_dict: visual dictionaries/features for the images [#images, feature_size].
num_image = size(images, 1);
feature_size = size(vocabulary, 1);
visual_dict = zeros(num_image, feature_size);
    for i_image = 1:num_image
        image = squeeze(images(i_image, :, :, :));
        descriptor = double(feature_extractor(image, sample_method, colorspace));   
        % Compute the pairwise distances from the extracted
        % features/descriptors to the features in the vocabulary.
        distance_matrix = pdist2(descriptor', vocabulary);
        % Assign each extracted features/descriptors to the closest feature
        % in the vocabulary and normalize the histogram.
        [~, indices] = min(distance_matrix, [], 2);
        visual_dict(i_image, :) = hist(indices, feature_size);
%         % L1-normalization.
%         visual_dict(i_image, :) = visual_dict(i_image, :) ./ sum(visual_dict(i_image, :));
        % L2-normalization.
        visual_dict(i_image, :) = visual_dict(i_image, :) ./ sqrt(sum(visual_dict(i_image, :) .^ 2));
    end
end