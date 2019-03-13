function [im_new] = stitch(im_1, im_2)
%STITCH a function that takes an image pair as input, and return the stitched version.

[f1, f2, matches, ~] = keypoint_matching(im_2, im_1); 
[x, ~] = RANSAC(f1, f2, matches, 0.999); 
T = affine2d([x(1) x(3) 0; x(2) x(4) 0; x(5) x(6) 1]);
% transform_im2 = image_transform(im_2, T);

[h_2, w_2] = size(im_2);

M = [x(1) x(2); x(3) x(4)];
t = [x(5); x(6)];
org_corners = [1 w_2 w_2 1;
                            1 1 h_2 h_2];
                        
for i = 1:size(org_corners, 2)
    corners(:, i) = M * org_corners(:, i) + t;
end

max_xy = max(corners, [],2);
max_x = max_xy(1);
max_y = max_xy(2);
min_xy = min(corners, [],2);
min_x  = min_xy(1);
min_y  = min_xy(2);

if min_y < 0
    h_offset = round(-min_y);        
else
     h_offset = 0;
end
canvas_h = h_offset + round(max(h_2, max_y));

if min_x <0
    w_offset = round(-min_x);
else
    w_offset = 0;
end
canvas_w = w_offset + round(max(w_2, max_x));

im_new = zeros(canvas_h, canvas_w);
new_im_1 = imtranslate(im_1, [h_offset w_offset], 'OutputView', 'full');
% new_im_2 = imtranslate(transform_im2, [round(t(1))  round(t(2))], 'OutputView', 'full');
transform_im2 = imwarp(im_2, T, 'OutputView', imref2d([canvas_h canvas_w]));
new_im_2 = transform_im2;
im_new(1:size(new_im_2, 1), 1:size(new_im_2, 2)) = new_im_2;
im_new(1:size(new_im_1, 1), 1:size(new_im_1, 2)) = new_im_1;
% 
% t_1 = x(5);
% t_2 = x(6);
% H = max(h_1, h_2 + t_2) - 1;
% W = max(w_1, t_1 + w_2) - 1;
% im_new(t_2:H, t_1:W) = transform_im2;
% im_new(1:h_1, 1:w_1) = im_1;
end
