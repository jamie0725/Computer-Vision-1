img1 = im2double(imread('./boat1.pgm'));

% transform the image by $\frac{\pi}{4}$, and shift by [10, 20]
T = affine2d([sqrt(2)/2 sqrt(2)/2 0; -sqrt(2)/2 sqrt(2)/2 0; 10 20 1]);

result = image_transform(img1, T);
imshow(result);