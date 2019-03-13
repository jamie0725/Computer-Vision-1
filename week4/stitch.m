function [im_new] = stitch(im_1, im_2)
%STITCH a function that takes an image pair as input, and return the stitched version.

[f1, f2, matches, ~] = keypoint_matching(im_2, im_1);
[x, ~] = RANSAC(f1, f2, matches, 0.999);
T = affine2d([x(1) x(3) 0; x(2) x(4) 0; -x(5) -x(6) 1]);
transform_im2 = image_transform(im_2, T);
[h_1, w_1] = size(im_1);
[h_2, w_2] = size(transform_im2);
t_1 = x(5);
t_2 = x(6);
H = max(h_1, h_2 + t_2) - 1;
W = max(w_1, t_1 + w_2) - 1;
im_new(t_2:H, t_1:W) = transform_im2;
im_new(1:h_1, 1:w_1) = im_1;
end

