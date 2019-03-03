function [H] = harris_corner_detector( image )
%HARRIS_CORNER_DETECTOR1 Summary of this function goes here
image_gray = rgb2gray(image);
I = im2double(image_gray);


size_image = size(image);
H = zeros(size_image);

sigma = 1;
halfwid = sigma * 1;
 
[xx, yy] = meshgrid(-halfwid:halfwid, -halfwid:halfwid);
 
Gx = xx .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
Gy = yy .* exp(-(xx .^ 2 + yy .^ 2) / (2 * sigma ^ 2));
 
%%apply sobel in herizontal direction and vertical direction compute the
%%gradient
%fx = [-1 0 1;-1 0 1;-1 0 1];
%fy = [1 1 1;0 0 0;-1 -1 -1];
Ix = conv2(I,Gx,'same');
Iy = conv2(I,Gy,'same');
%%compute Ix2, Iy2,Ixy
Ix2 = Ix.*Ix;
Iy2 = Iy.*Iy;
Ixy = Ix.*Iy;
 
%%apply gaussian filter
%h = fspecial('gaussian',[6,6],1);

h = gauss2D(1, 3);

Ix2 = conv2(Ix2,h,'same');
Iy2 = conv2(Iy2,h,'same');
Ixy = conv2(Ixy,h,'same');
height = size(I,1);
width = size(I,2);
result = zeros(height,width);
R = zeros(height,width);
Rmax = 0;
%% compute M matrix and corner response
for i = 1:height
    for j =1:width
        M = [Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)];
        R(i,j) = det(M) - 0.04*(trace(M)^2);
        if R(i,j)> Rmax
            Rmax = R(i,j);
        end
    end
end
%% compare whith threshold
count = 0;
for i = 2:height-1
    for j = 2:width-1
        if R(i,j) > 0.01*Rmax
            result(i,j) = 1;
            count = count +1;
        end
    end
end
 
%non-maxima suppression
result = imdilate(result, [1 1 1; 1 0 1; 1 1 1]);
 
[posc,posr] = find(result == 1);
imshow(I);
hold on;
plot(posr,posc,'r.')
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