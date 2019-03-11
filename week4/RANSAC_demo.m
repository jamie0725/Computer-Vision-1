I1 = im2single(imread('boat1.pgm'));
I2 = im2single(imread('boat2.pgm'));

[f1, f2, matches, scores] = keypoint_matching(I1, I2);

[x] = RANSAC( f1,f2,matches,10);

T = affine2d([x(1) x(2) 0; x(3) x(4) 0; x(5) x(6) 1]);

% image transform from boat 2 to boat 1.
f1 = figure();
subplot(1,2,1);
% transform with MATLAB built-in function imwarp.
out_image1 = imwarp(I2, T);
imshow(im2uint8(out_image1));
title('Transformation with built-in imwarp');
subplot(1,2,2);
% transform with our image_transform.m.
out_image2 = image_transform(I2, T);
imshow(im2uint8(out_image2));
title('Transformation with image\_transform');
sgtitle('Image transformation from boat2 to boat1');
saveas(f1,'./results/boat2toboat1.eps','epsc');