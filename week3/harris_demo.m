image = imread('person_toy/00000001.jpg');
[H,r,c] = harris_corner_detector(image, 500000, 5,'All');

image = imread('pingpong/0000.jpeg');
[H,r,c] = harris_corner_detector(image, 400, 5,'All');
%%
%%Image "person\_toy.jpg" with corners under different threshold and window size values.
%%
clear all;
image = imread('pingpong/0000.jpeg');
pingpong_different = figure;

[H,r,c] = harris_corner_detector(image, 200, 3,'F');
subplot(2,2,1);plot_image_and_corners(image,r,c);
title('threshold:200, window size:3*3');
[H,r,c] = harris_corner_detector(image, 200, 5,'F');
subplot(2,2,2);plot_image_and_corners(image,r,c);
title('threshold:200, window size:5*5');
[H,r,c] = harris_corner_detector(image, 400, 3,'F');
subplot(2,2,3);plot_image_and_corners(image,r,c);
title('threshold:400, window size:3*3');
[H,r,c] = harris_corner_detector(image, 400, 5,'F');
subplot(2,2,4);plot_image_and_corners(image,r,c);
title('threshold:400, window size:5*5');
%plot the final image
saveas(pingpong_different,'pingpong_different.eps','epsc');
%%
%%Image "pingpong.jpg" with corners under different threshold and window size values.
%%
clear all;
image = imread('person_toy/00000001.jpg');
toy_different = figure;

[H,r,c] = harris_corner_detector(image, 100000, 3,'F');
subplot(2,2,1);plot_image_and_corners(image,r,c);
title('threshold:100000, window size:3*3');
[H,r,c] = harris_corner_detector(image, 100000, 5,'F');
subplot(2,2,2);plot_image_and_corners(image,r,c);
title('threshold:100000, window size:5*5');
[H,r,c] = harris_corner_detector(image, 500000, 3,'F');
subplot(2,2,3);plot_image_and_corners(image,r,c);
title('threshold:500000, window size:3*3');
[H,r,c] = harris_corner_detector(image, 500000, 5,'F');
subplot(2,2,4);plot_image_and_corners(image,r,c);
title('threshold:500000, window size:5*5');
%plot the final image
saveas(toy_different,'toy_different.eps','epsc');
%%
%%Image ¡±persontoy.jpg¡± with corners with different rotations
%%
image = imread('person_toy/00000001.jpg');
rotate_toy= figure;

[H,r,c] = harris_corner_detector(image, 500000, 5,'F');
subplot(1,3,1);plot_image_and_corners(image,r,c);
title('original image');
%rotate 45
[oimg] = rotate45(image);
[H,r,c] = harris_corner_detector(oimg, 500000, 5,'F');
subplot(1,3,2);plot_image_and_corners(oimg,r,c);
title('rotate the image 45 degrees');
%rotate 90 degrees
image = rot90(image,1);
[H,r,c] = harris_corner_detector(image, 500000, 5,'F');
subplot(1,3,3);plot_image_and_corners(image,r,c);
title('rotate the image 90 degrees');
%plot the final image
saveas(rotate_toy,'rotate_toy.eps','epsc');
%%
function plot_image_and_corners(image,r,c)
    imshow(image);hold on;
    plot(r,c,'r.','MarkerSize',10)
end

function [oimg] = rotate45(image)
    img=imcomplement(image);
    r = numel(img(:,1));c = numel(img(:,2));nimg = imrotate(img, 45);
    n_R = numel(nimg(:,1));n_C = numel(nimg(:,2));
    n_R = n_R+mod(n_R, 2);n_C = n_C+mod(n_C, 2);
    oimg = nimg(((n_R/2)-(r/2)):((n_R/2)+(r/2)), ((n_C/2)-(c/2)):((n_C/2)+(c/2)),:);
    oimg = imcomplement(oimg);
end
%%