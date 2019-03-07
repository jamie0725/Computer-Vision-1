function [f1, f2, matches, scores] = keypoint_matching(img1, img2)
%keypoint_matching: Extract the sift features from the two images and find
%matchings.
%inputs: single precision grayscale images img1 and img2
%outputs: closest matches in img2 to feature points in img1 with their
%corresponding scores.
[f1, d1] = vl_sift(img1) ;
[f2, d2] = vl_sift(img2) ;
[matches, scores] = vl_ubcmatch(d1, d2) ;
end

