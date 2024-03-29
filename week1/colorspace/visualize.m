function visualize(input_image)

size_input_image = size(input_image);
if size_input_image(3) == 3
    image = figure;
    subplot(1,4,1);   
    imshow(input_image);
    title('new image');
    
    subplot(1,4,2);
    imshow(input_image(:,:,1));
    title('channel 1');

    subplot(1,4,3);
    imshow(input_image(:,:,2));
    title('channel 2');

    subplot(1,4,4);
    imshow(input_image(:,:,3));
    title('channel 3');

    %saveas(image,'./colorspace/images/output_image.eps','epsc');
    
elseif size_input_image(3) == 4
    image = figure;
    subplot(1,4,1);   
    imshow(input_image(:,:,1));
    title('built-in function');

    subplot(1,4,2);
    imshow(input_image(:,:,2));
    title('Lightness');

    subplot(1,4,3);
    imshow(input_image(:,:,3));
    title('Average');

    subplot(1,4,4);
    imshow(input_image(:,:,4));
    title('Luminosity');

    %saveas(image,'./colorspace/images/CS_gray','epsc');

end

