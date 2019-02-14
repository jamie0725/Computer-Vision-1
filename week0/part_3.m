%%% 3.1 %%%
I = imread('peppers.png'); % reads the image into marrix I
size(I) % 384 x 512 x 3 = row x columns x color channels (RGB in this case)
figure(1) % creates a figure on the screen
imshow(I) % displays the matrix I as an image
imwrite (I, './myimage.png'); % writes image data I to the file
%%% 3.2 %%%
% 3.2.1
im1 = imread('peppers.png'); % reads the image into matrix I
im2 = im2double(im1); % converts image to double precision
% converts RGB image to grayscale: 0.2989 * R + 0.5870 * G + 0.1140 * B %
im3 = rgb2gray(im2);
figure(2) % creates a figure on the screen
imshow(im3) % displays the grayscale image
% 3.2.2
J = imread('pout.tif'); % read a grayscale image into matrix I
figure(3) % creates a figure on the screen
imhist(J) % displays the distribution of image pixel intensities
% Notice how the histogram indicates that the intensity range of the image is
% rather narrow. The range does not cover the potential range of [0, 255], and
% is missing the high and low values that would result in good contrast.
J2 = histeq(J); % spreads the intensity values over the full range of the image
figure(4) % creates a figure on the screen
imshow(J2) % displays contrast enhanced image
figure(5) % creates a figure on the screen
imshow(J) % displays original image
% 3.2.3
P = imread('cameraman.tif'); % read an image into matrix P
figure(5) % creates a figure on the screen
imshow(P) % display the original image
S = imresize(P, 0.5) % scale the original image into its half size
figure(6) % creates a figure on the screen
imshow(S) % display the scaled image
