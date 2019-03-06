function [H,r,c] = harris_corner_detector( image, threshold, N, pChoice )
%%HARRIS_CORNER_DETECTOR1
%Input:--------------
%image:original image
%threshold
%N:the size of the window
%pChoice:judge whether plot the figure('All';'IxIy';'One';'F':do not plot)
%Outpot:--------------
%The Matrix H and the row and column of the corner(r and c)
%sigma = 1 and kernel size = 3*3 for the Gaussian and its first order derivative filter.

%read the transfer the image
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

%%compute the gradient
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

if pChoice == 'All'%plot all the images
    three_figures = figure;
    subplot(1,3,1);imshow(Ix);title('Ix');
    subplot(1,3,2);imshow(Iy);title('Iy');
    subplot(1,3,3);imshow(image);hold on;
    plot(r,c,'r.','MarkerSize',10)
    title('original image with conrner points');
    saveas(three_figures,'./result_harris/harris.eps','epsc');
elseif pChoice == 'IxIy'%plot IxIy
    two_figures = figure;
    subplot(1,2,1);imshow(Ix);title('Ix');
    subplot(1,2,2);imshow(Iy);title('Iy');
    saveas(two_figures,'harris_IxIy.eps','epsc');
elseif pChoice == 'One'
    one_figure = figure;imshow(image);hold on;
    plot(r,c,'r.','MarkerSize',10)
    title('original image with conrner points');
    saveas(one_figure,'harris_one.eps','epsc');
else
end
%plot the final image

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