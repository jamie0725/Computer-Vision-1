function [out_im] = stitch(im_1,im_2)
%STITCH a function that takes an image pair as input, and return the stitched version.

[f1, f2, matches, ~] = keypoint_matching(im_1, im_2);
[x] = RANSAC(f1, f2, matches, 10);





end

