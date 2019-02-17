I = imread('./awb.jpg');
AWB_I = grey_world(I);
out_I = figure(1);
subplot(1,2,1);
imshow(I);
title('Original Figure');
subplot(1,2,2);
imshow(AWB_I);
title('AWB Figure with GWA');
saveas(out_I,'output.eps','epsc');
saveas(out_I,'output.jpg');

function awb = grey_world(image)
%GREY_WORLD return the automatic white balanced image of the input image with grey_world assumption
%   image : the input image

% color channels of the input image
r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);

% the mean of each channel of the image
avgR = mean(mean(r));
avgG = mean(mean(g));
avgB = mean(mean(b));

avgRGB = [avgR avgG avgB];

% scale the pixel values of each channel
sValue = 128 ./ avgRGB;
awb(:,:,1) = r * sValue(1);
awb(:,:,2) = g * sValue(2);
awb(:,:,3) = b * sValue(3);

end