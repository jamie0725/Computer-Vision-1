albedo = imread('./ball_albedo.png');
shading = imread('./ball_shading.png');
original_img = imread('./ball.png');

original_img = original_img./255;

double_albedo = double(albedo)./255;
double_shading = double(shading)./255;
reconstructed_img = (double_albedo.*double_shading)*255;
% max(shading(:))
% max(albedo(:))
max(reconstructed_img(:))
% max(original_img(:)./255)
prediff = abs(im2double(original_img)-reconstructed_img);
diff = max(prediff(:));
fprintf('max difference between original image and reconstructed image %f', diff)
subplot(2,2,1)
imshow(albedo)
subplot(2,2,2)
imshow(shading)
subplot(2,2,3)
imshow(uint16(original_img)*255)
subplot(2,2,4)
imshow(uint16(reconstructed_img*255))