function [ descriptor ] = feature_extractor( image, sample_method, colorspace )
%FEATURE_EXTRACTOR Extract features of the given image.
%   image: original image.
%   sample_method: 'dense' or 'key'.
%   colorspace: 'rgb', 'orgb', 'grey'.
%   descriptor: the extracted descriptors of the given image.

greyImage = single(rgb2gray(image)); % convert image to singal-precison grey-scale image.
RImage = single(image(:, :, 1)); % separate the R channel for RGB colorspace.
GImage = single(image(:, :, 2)); % separate the G channel for RGB colorspace.
BImage = single(image(:, :, 3)); % separate the B channel for RGB colorspace.
O1Image = (RImage - GImage) / sqrt(2); % separate the O1 channel for Opponent colorspace.
O2Image = (RImage + GImage - 2 * BImage) / sqrt(6); % separate the O2 channel for Opponent colorspace.
O3Image = (RImage + GImage + BImage) / sqrt(3); % separate the O3 channel for Opponent colorspace.

if strcmp(sample_method, 'key')
    [frames, descriptor] = vl_sift(greyImage, 'PeakThresh', 1.5); % SIFT key-point sampling for grey-scale image.
    if strcmp(colorspace, 'rgb')
        [~, Rdescriptor] = vl_sift(RImage, 'Frames', frames); % SIFT key-point sampling for R channel.
        [~, Gdescriptor] = vl_sift(GImage, 'Frames', frames); % SIFT key-point sampling for G channel.
        [~, Bdescriptor] = vl_sift(BImage, 'Frames', frames); % SIFT key-point sampling for B channel.
        descriptor = cat(1, Rdescriptor, Gdescriptor, Bdescriptor);
%         descriptor = reshape(descriptor, 128, 3, []);
    elseif strcmp(colorspace, 'orgb')
        [~, O1descriptor] = vl_sift(O1Image, 'Frames', frames); % SIFT key-point sampling for O1 channel.
        [~, O2descriptor] = vl_sift(O2Image, 'Frames', frames); % SIFT key-point sampling for O2 channel.
        [~, O3descriptor] = vl_sift(O3Image, 'Frames', frames); % SIFT key-point sampling for O3 channel.
        descriptor = cat(1, O1descriptor, O2descriptor, O3descriptor);
%         descriptor = reshape(descriptor, 128, 3, []);
    end
elseif strcmp(sample_method, 'dense')
    if strcmp(colorspace, 'grey')
        [~, descriptor] = vl_dsift(greyImage, 'Step', 5); % SIFT dense sampling for grey-scale image.
    elseif strcmp(colorspace, 'rgb')
        [~, Rdescriptor] = vl_dsift(RImage, 'Step', 5); % SIFT dense sampling for R channel.
        [~, Gdescriptor] = vl_dsift(GImage, 'Step', 5); % SIFT dense sampling for G channel.
        [~, Bdescriptor] = vl_dsift(BImage, 'Step', 5); % SIFT dense sampling for B channel.
        descriptor = cat(1, Rdescriptor, Gdescriptor, Bdescriptor);
%         descriptor = reshape(descriptor, 128, 3, []);
    elseif strcmp(colorspace, 'orgb')
        [~, O1descriptor] = vl_dsift(O1Image, 'Step', 5); % SIFT dense sampling for O1 channel.
        [~, O2descriptor] = vl_dsift(O2Image, 'Step', 5); % SIFT dense sampling for O2 channel.
        [~, O3descriptor] = vl_dsift(O3Image, 'Step', 5); % SIFT dense sampling for O3 channel.
        descriptor = cat(1, O1descriptor, O2descriptor, O3descriptor);
%         descriptor = reshape(descriptor, 128, 3, []);
    end
end
    
end
