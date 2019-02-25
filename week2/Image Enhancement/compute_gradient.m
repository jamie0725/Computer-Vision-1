function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
sobel = [1, 0, -1; 2, 0, -2; 1, 0, -1]; % define the sobel kernel for x-direction (transpose for y-direction).
Gx = imfilter(image, sobel, 'replicate', 'conv'); % compute Gx by convolution between image and sobel filter.
Gy = imfilter(image, sobel', 'replicate', 'conv'); % compute Gy by convolution between image and (transposed) sobel filter.
im_magnitude = sqrt(Gx.^2 + Gy.^2);
im_direction = atan2d(-Gy, Gx); % determine the angle (in degrees) based on the conventional y-up coordinate system.
end