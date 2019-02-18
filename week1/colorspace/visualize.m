function visualize(input_image)

size_input_image = size(input_image);
if size_input_image(3) == 3
    image = figure(1);
    subplot(1,4,1);   
    imshow(input_image);

    subplot(1,4,2);
    imshow(input_image(:,:,1));

    subplot(1,4,3);
    imshow(input_image(:,:,2));

    subplot(1,4,4);
    imshow(input_image(:,:,3));

    saveas(image,'output_image.eps','epsc');
    
elseif size_input_image(3) == 4
    image = figure(1);
    subplot(1,4,1);   
    imshow(input_image(:,:,1));

    subplot(1,4,2);
    imshow(input_image(:,:,2));

    subplot(1,4,3);
    imshow(input_image(:,:,3));

    subplot(1,4,4);
    imshow(input_image(:,:,4));

    saveas(image,'output_image.eps','epsc');      

end

