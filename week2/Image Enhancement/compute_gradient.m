function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
Gx = conv2(image, [1, 0, -1; 2, 0, -2; 1, 0, -1]);
Gy = conv2(image, [1, 2, 1; 0, 0, 0; -1, -2, -1]);
im_magnitude = sqrt(Gx.^2 + Gy.^2);
im_direction = atan(Gy ./ Gx);
end