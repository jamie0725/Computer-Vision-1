img1 = im2double(imread('./boat1.pgm'));
% m = zeros(2,2);
% m(1,1) = sqrt(2)/2;
% m(1,2) = sqrt(2)/2;
% m(2,1) = -sqrt(2)/2;
% m(2,2) = sqrt(2)/2;
% 
% b = zeros(1,2);
% b(1,1) = 10;
% b(1,2) = 20;

T = affine2d([sqrt(2)/2 sqrt(2)/2 0; -sqrt(2)/2 sqrt(2)/2 0; 10 20 1]);

result = image_transform(img1, T);
imshow(result);