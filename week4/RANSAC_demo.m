I1 = im2single(imread('boat1.pgm'));
I2 = im2single(imread('boat2.pgm'));

%I1 = im2single(rgb2gray(imread('left.jpg')));
%I2 = im2single(rgb2gray(imread('right.jpg')));

[f1, f2, matches, scores] = keypoint_matching(I2, I1);

[x, matching_points] = RANSAC(f1, f2, matches, 0.999);

T = affine2d([x(1) x(3) 0; x(2) x(4) 0; x(5) x(6) 1]);  % T is transformation from I2 to I1

% image transform from boat 2 to boat 1.
fig1 = figure();
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
title('Image transformation from boat2 to boat1');
saveas(fig1,'./results/boat2toboat1.eps','epsc');

out_image1 = im2uint8(I1);
out_image2 = im2uint8(image_transform(I2, T));
size_image2 = size(out_image2);
out_image1 = [out_image1 zeros(680,size_image2(2)-850)];
out_image1 = [out_image1;zeros(size_image2(1)-680,size_image2(2))];

fig2 = figure();
Is = cat(4, out_image1,out_image2 );
mnt = montage(Is, 'Size', [1 2]);
title('Image transformation from boat2 to boat1');
hold on
p1_image = matching_points([1 2],:);
p2_image = matching_points([3 4],:);
% x_offset = size(out_image1, 2);
% for i=1:size(matching_points,2)
%     p1 = p1_image(:,i);
%     p2 = p2_image(:,i);
%     p2(1) = p2(1) + x_offset;
%     p2(2) = p2(2);
%     % Visualize keypoints and the connections between matches.
%     plot(p1(1), p1(2), 'bo', 'LineWidth', 2.5, 'MarkerSize', 15)
%     plot(p2(1), p2(2), 'rx', 'LineWidth', 2.5, 'MarkerSize', 15)
%     line([p1(1), p2(1)], [p1(2), p2(2)], 'LineWidth', 2.5, 'color',rand(1,3))
% end
% hold off
% saveas(fig2,'./results/boat1_and_boat2_to_boat1.eps','epsc');

%f = figure();
%imshow(im2uint8(I1));
%hold on;
%out_image1 = imwarp(I2, T);
%imshow(im2uint8(out_image1));
%hold on;
%imshow(im2uint8(I1))
