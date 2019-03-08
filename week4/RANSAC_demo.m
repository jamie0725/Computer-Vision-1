I1 = im2single(imread('boat1.pgm'));
I2 = im2single(imread('boat2.pgm'));

[f1, f2, matches, scores] = keypoint_matching(I1, I2);

[x] = RANSAC( f1,f2,matches,10);

T = affine2d([x(1) x(2) 0; x(3) x(4) 0; x(5) x(6) 1]);

choice = "imwarp";
if choice == "imwarp"
    Image = imwarp(I2, T);
else
    Image = image_transform(I2, T);
end

imshow(im2uint8(Image));
