image = imread('person_toy/00000001.jpg');
[H,r,c] = harris_corner_detector(image, 500000, 5);

image = imread('pingpong/0000.jpeg');
[H,r,c] = harris_corner_detector(image, 400, 5);
%%Image "person\_toy.jpg" with corners under different threshold and window size values.
%%
clear all;
image = imread('pingpong/0000.jpeg');
three_figures = figure;

[H,r,c] = harris_corner_detector1(image, 200, 3);
subplot(2,2,1);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('threshold:200, window size:3*3');

[H,r,c] = harris_corner_detector1(image, 200, 5);
subplot(2,2,2);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('threshold:200, window size:5*5');

[H,r,c] = harris_corner_detector1(image, 400, 3);
subplot(2,2,3);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('threshold:400, window size:3*3');

[H,r,c] = harris_corner_detector1(image, 400, 5);
subplot(2,2,4);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('threshold:400, window size:5*5');
%plot the final image

saveas(three_figures,'pingpong_different.eps','epsc');
%%Image "pingpong.jpg" with corners under different threshold and window size values.
%%
clear all;
image = imread('person_toy/00000001.jpg');

three_figures = figure;

[H,r,c] = harris_corner_detector1(image, 100000, 3);
subplot(2,2,1);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('threshold:100000, window size:3*3');

[H,r,c] = harris_corner_detector1(image, 100000, 5);
subplot(2,2,2);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('threshold:100000, window size:5*5');

[H,r,c] = harris_corner_detector1(image, 500000, 3);
subplot(2,2,3);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('threshold:500000, window size:3*3');

[H,r,c] = harris_corner_detector1(image, 500000, 5);
subplot(2,2,4);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('threshold:500000, window size:5*5');
%plot the final image

saveas(three_figures,'toy_different.eps','epsc');

%%Image ¡±persontoy.jpg¡± with corners with different rotations
%%
image = imread('person_toy/00000001.jpg');

rotate_toy= figure;

[H,r,c] = harris_corner_detector1(image, 500000, 5);
subplot(1,3,1);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('original image');

%rotate 45
img=imcomplement(image);
r = numel(img(:,1));
c = numel(img(:,2));
nimg = imrotate(img, 45);
n_R = numel(nimg(:,1));
n_C = numel(nimg(:,2));
n_R = n_R+mod(n_R, 2); %to avoid dimensions being in double datatype
n_C = n_C+mod(n_C, 2);
oimg = nimg(((n_R/2)-(r/2)):((n_R/2)+(r/2)), ((n_C/2)-(c/2)):((n_C/2)+(c/2)),:);
oimg = imcomplement(oimg);
[H,r,c] = harris_corner_detector1(oimg, 500000, 5);
subplot(1,3,2);   
imshow(oimg);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('rotate the image 45 degrees');

image = rot90(image,1);

[H,r,c] = harris_corner_detector1(image, 500000, 5);
subplot(1,3,3);   
imshow(image);
hold on;
plot(r,c,'r.','MarkerSize',10)
title('rotate the image 90 degrees');


%plot the final image

saveas(rotate_toy,'rotate_toy.eps','epsc');

function [H,r,c] = harris_corner_detector1( image, threshold, N)
%HARRIS_CORNER_DETECTOR1 Summary of this function goes here
image_gray = rgb2gray(image);
I = im2double(image_gray);
height = size(I,1);
width = size(I,2);


sigma = 1;
kernel_size = 3;
kernel_radius = (kernel_size - 1)/2;
 
[xx, yy] = meshgrid(-kernel_radius:kernel_radius, -kernel_radius:kernel_radius);
 
%compute the first derivative of Gaussian filter
Gx = xx .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
Gy = yy .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));

%%compute the gradient and plot the images
Ix = conv2(I,Gx,'same');
Iy = conv2(I,Gy,'same');

%%compute Ix2, Iy2,Ixy
Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;
 
%%apply gaussian filter
h = gauss2D(sigma, kernel_size);

Ix2 = conv2(Ix2,h,'same');
Iy2 = conv2(Iy2,h,'same');
Ixy = conv2(Ixy,h,'same');

%% compute H matrix and Q
Q = zeros(height,width);
for i = 1:height
    for j =1:width
        H = [Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)];
        Q(i,j) = det(H) - 0.04*(trace(H)^2);
    end
end

%% If the point is a local maximum and compare whith threshold
N_radius = (N - 1)/2;

%compute the threshold
Q_median = median(Q(:));
Q_threshold = threshold * Q_median;
        
result = zeros(height,width);
for i = 1+N_radius:height-N_radius
    for j = 1+N_radius:width-N_radius
        %compute the local maximum
        Q_local = Q(i-N_radius:i+N_radius,j-N_radius:j+N_radius);
        local_max = max(max(Q_local)); 
        if Q(i,j) > Q_threshold && Q(i,j) == local_max
            result(i,j) = 1;
        end
    end
end
 
 
[c,r] = find(result == 1);


end


function G = gauss2D( sigma , kernel_size )
    %% solution
    G_x = gauss1D(sigma, kernel_size);
    G_y = gauss1D(sigma, kernel_size);
    G = G_x' * G_y;
end

function G = gauss1D( sigma , kernel_size )
    %G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    x = -floor(kernel_size / 2):floor(kernel_size / 2);
    G = 1 / (sigma * sqrt(2 * pi)) * exp(- (x .^ 2) / (2 * sigma ^ 2)); 
    G = G / sum(G);
end