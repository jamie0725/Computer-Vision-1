image = imread('pingpong/0000.jpeg');
figure(1);
[H,r,c] = harris_corner_detector(image, 0.002, 3);
imshow(image);
hold on;
plot(r,c,'r.')

figure(2);
image = imread('person_toy/00000104.jpg');
[H,r,c] = harris_corner_detector(image, 0.003, 3);
imshow(image);
hold on;
plot(r,c,'r.')


