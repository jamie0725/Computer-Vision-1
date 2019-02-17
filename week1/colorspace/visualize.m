function visualize(input_image)

subplot(2,2,1);   
imshow(input_image);

subplot(2,2,2);
image_1 = input_image(:,:,1);
imshow(image_1);

subplot(2,2,3);
%image_2 = zeros(size(input_image));
image_2 = input_image(:,:,2);
imshow(image_2);

subplot(2,2,4);
%image_3 = zeros(size(input_image));
image_3 = input_image(:,:,3);
imshow(image_3);
end

