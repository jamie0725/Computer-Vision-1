function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods

% ligtness method
[R, G, B] = getColorChannels(input_image);
size_image = size(input_image);
output_image_lightness = zeros(size_image(1),size_image(2));
for i = 1:size_image(1)
    for j = 1:size_image(2)
        output_image_lightness(i,j) = (max([R(i,j),G(i,j),B(i,j)]) + min([R(i,j),G(i,j),B(i,j)])) / 2;
    end
end

% average method
output_image_average = (R + G + B) / 3;
% luminosity method
output_image_luminosity = 0.21 * R + 0.72 * G + 0.07 * B;
% built-in MATLAB function 
output_image_builtin = rgb2gray(input_image);

output_image = zeros(size_image(1), size_image(2), 4);
output_image(:,:,1) = output_image_builtin;
output_image(:,:,2) = output_image_lightness;
output_image(:,:,3) = output_image_average;
output_image(:,:,4) = output_image_luminosity;

end

