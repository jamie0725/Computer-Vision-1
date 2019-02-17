albedo = imread('./ball_albedo.png');
shading = imread('./ball_shading.png');
original_img = imread('./ball.png');

albedo = double(albedo)./255;
shading = double(shading)./255;
reconstructed_img = (albedo.*shading)*255;
% max(shading(:))
% max(albedo(:))
% max(reconstructed_img(:))
prediff = abs(double(original_img)./255-reconstructed_img);
diff = max(prediff(:));
fprintf('max difference between original image and reconstructed image %lf', diff)

% imshow(albedo)