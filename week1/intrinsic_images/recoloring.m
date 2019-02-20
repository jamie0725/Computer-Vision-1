% read the images needed
albedo = im2double(imread('./ball_albedo.png'));
shading = im2double(imread('./ball_shading.png'));
original_img = im2double(imread('./ball.png'));

% separate three channels
albedo_r = albedo(:,:,1); % Red channel
albedo_g = albedo(:,:,2); % Green channel
albedo_b = albedo(:,:,3); % Blue channel
% find the true color of each channel
true_r = max(albedo_r(:));
true_g = max(albedo_g(:));
true_b = max(albedo_b(:));

[true_r, true_g, true_b] % true colors

% find the mask of the object in image
image_mask = double(albedo>0);

% separate the masks
r_c = image_mask(:, :, 1);
g_c = image_mask(:, :, 2);
b_c = image_mask(:, :, 3);

% remove the red and blue channel
green_img = cat(3, r_c*0, g_c*1, b_c*0).*shading;
fig=figure(1)
subplot(1,4,1)
imshow(albedo)
title("albedo")
subplot(1,4,2)
imshow(shading)
title("shading")
subplot(1,4,3)
imshow(original_img)
title("original image")
subplot(1,4,4)
imshow(green_img)
title("green image")

saveas(fig, "./green_ball.eps", "epsc")
