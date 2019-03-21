function vocabulary = build_vocabulary(images, feature_size, sample_method, colorspace)
%BUILD_VOCABULARY Extract features of the chosen subset of images and create a visual vocabulary using k-means clustering.
%   images: subset of images [#images, w, h, channels].
%   feature_size: Number of clusters/features.
%   sample_method: 'dense' or 'key'.
%   colorspace: 'rgb', 'orgb', 'grey'.
%   vocabulary: coordinates of the centroids (visual words) [feature_size, (128 for grayscale-SIFT, 128 * 3 for RGB-SIFT and opponent-SIFT)].

for i_image = 1:size(images, 1)
    image = squeeze(images(i_image, :, :, :));
    descriptor = double(feature_extractor(image, sample_method, colorspace));
    % Vertically stack the extracted features.
    if i_image == 1
        descriptors = descriptor';
    else
        descriptors = [descriptors; descriptor'];
    end    
end
% Run k-means for clustering the visual words into a vocabulary.
[~, vocabulary] = kmeans(descriptors, feature_size);
end