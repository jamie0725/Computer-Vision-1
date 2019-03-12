function [T] = stitch(im_1, im_2)
%STITCH a function that takes an image pair as input, and return the stitched version.

[f1, f2, matches, ~] = keypoint_matching(im_1, im_2);
[x, points] = RANSAC(f1, f2, matches, 11);
x1 = reshape(f1(1,points(1, :)), [], 1);
y1 = reshape(f1(2,points(1, :)), [], 1);
x2 = reshape(f2(1,points(2, :)), [], 1);
y2 = reshape(f2(2,points(2, :)), [], 1);
T = affine2d([x(1) x(2) 0; x(3) x(4) 0; x(5) x(6) 1]);
transform_im2 = image_transform(im_2, T);
[h, w] = size(im_1);
l_r= w - des1(1,2) + des2(1,2);
L = W + 1 - l_r
R = W

figure();
subplot(1,2,1);
imshow(im_1);
subplot(1,2,2);
imshow(transform_im2);
end

