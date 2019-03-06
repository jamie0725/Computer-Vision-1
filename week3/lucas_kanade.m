function [ Vx, Vy, plot ] = lucas_kanade( im_1, im_2, pChoice )
%LUCAS_KANADE The Lucas-Kanade method for Optical Flow estimation.
% im_1: input image of the previous frame.
% im_2: input image of the current frame.
% pChoice: choose whether to show the output plot ('T'/'F').


if length(size(im_1)) == 3 % convert rgb images to greyscale images if necessary.
    image_1 = im2double(rgb2gray(im_1));
    image_2 = im2double(rgb2gray(im_2));
else
    image_1 = im2double(im_1); % convert to double if necessary.
    image_2 = im2double(im_2);
end

[h_1, w_1] = size(image_1);

[Ix, Iy] = imgradientxy(image_1); % compute the partial derivative of image_1 in the x- and y-direction.
It = image_2 - image_1;  % compute the partial derivative between image_2 and image_1 w.r.t. time.

winSize = 15;
side = floor(winSize/2); % number of pixels at each side of the center pixel.
center = ceil(winSize/2); % starting center pixel.

Vx = zeros(floor(h_1/winSize), floor(w_1/winSize)); % initialize size of Vx.
Vy = zeros(size(Vx)); % initialize size of Vy.

for i=center:winSize:h_1-side
    for j=center:winSize:w_1-side
        tmp_Ix = Ix(i-side:i+side, j-side:j+side); % copy all partial derivative in x-direction in the current region.
        tmp_Ix = reshape(tmp_Ix, [], 1); % reshape the matrix to a vector.
        tmp_Iy = Iy(i-side:i+side, j-side:j+side); % copy all partial derivative in y-direction in the current region.
        tmp_Iy = reshape(tmp_Iy, [], 1); % reshape the matrix to a vector.
        tmp_It = It(i-side:i+side, j-side:j+side); % copy all partial derivative in time in the current region.
        tmp_A = [tmp_Ix, tmp_Iy]; % matrix A of the current region.
        tmp_b = -reshape(tmp_It, [], 1); % reshape the matrix to a vector.
        v = pinv(tmp_A) * tmp_b; % solve v given in Eq. 20: multiplication of pseudo-inverse of A and b.
        index_x = ceil(i/winSize);
        index_y = ceil(j/winSize);
        Vx(index_x, index_y) = v(1); % store the v_x of the current region.
        Vy(index_x, index_y) = v(2); % store the v_y of the current region.
    end
end

if pChoice == 'T' % show the output plot if is needed.
    [X, Y] = meshgrid(center:winSize:w_1-side, center:winSize:h_1-side);
    plot = figure();
    imshow(im_2);
    title('Lucas-Kanade method for Optical Flow estimation.');
    hold on;
    quiver(X, Y, Vx, Vy); % plotting.
    hold off;
else
    plot = 'None';
end
end

