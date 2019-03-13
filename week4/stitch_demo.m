clear all
close all
% read input images.
im1 = imread('./left.jpg');
im2 = imread('./right.jpg'); 

% convert to single precision grey-scale images.
pro1 = im2single(rgb2gray(im1));
pro2 = im2single(rgb2gray(im2));
[stitched] = stitch(pro1, pro2);
fig = figure();
imshow(stitched);
saveas(fig, 'results/q2.eps', 'epsc')