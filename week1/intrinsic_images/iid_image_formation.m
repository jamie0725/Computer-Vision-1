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

figure,
subplot(1,4,1)
imshow(albedo)
title("albedo")
subplot(1,4,2)
imshow(shading)
title("shading")
subplot(1,4,3)
imshow(uint16(original_img)*255)
title("original image")
subplot(1,4,4)
imshow(uint16(reconstructed_img*255))
title("reconstructed image")

saveas(gca, "./reconstruction.eps", "epsc")