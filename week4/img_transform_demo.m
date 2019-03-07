img1 = im2double(imread('./boat1.pgm'));
m = zeros(2,2);
m(1,1) = sqrt(2)/2;
m(1,2) = sqrt(2)/2;
m(2,1) = -sqrt(2)/2;
m(2,2) = sqrt(2)/2;

b = zeros(1,2);
b(1,1) = 10;
b(1,2) = 20;

result = image_transform(img1, m, b);
imshow(result);