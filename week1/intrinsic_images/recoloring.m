albedo = im2double(imread('./ball_albedo.png'));
shading = im2double(imread('./ball_shading.png'));
original_img = im2double(imread('./ball.png'));

albedo_r = albedo(:,:,1); % Red channel
albedo_g = albedo(:,:,2); % Green channel
albedo_b = albedo(:,:,3); % Blue channel

true_r = max(albedo_r(:));
true_g = max(albedo_g(:));
true_b = max(albedo_b(:));

[true_r, true_g, true_b]; % true colors

image_mask = double(albedo>0);

r_c = image_mask(:, :, 1);
g_c = image_mask(:, :, 2);
b_c = image_mask(:, :, 3);

green_img = cat(3, r_c*0, g_c*1, b_c*0).*shading;

subplot(2,2,1)
imshow(albedo)
subplot(2,2,2)
imshow(shading)
subplot(2,2,3)
imshow(original_img)
subplot(2,2,4)
imshow(green_img)