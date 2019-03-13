I1 = im2single(imread('boat1.pgm'));
I2 = im2single(imread('boat2.pgm'));

% img_1 to img_2
[f1_1, f2_1, matches_1, ~] = keypoint_matching(I1, I2);

[x, matching_points_1] = RANSAC(f1_1, f2_1, matches_1, 0.999);

T = affine2d([x(1) x(3) 0; x(2) x(4) 0; x(5) x(6) 1]);

% img_2 to img_1
[f1_2, f2_2, matches_2, ~] = keypoint_matching(I2, I1);

[x, matching_points_2] = RANSAC(f1_2, f2_2, matches_2, 0.999);

inv_T = affine2d([x(1) x(3) 0; x(2) x(4) 0; x(5) x(6) 1]);

% comparison of using imwarp and image_transform.m.
fig1 = figure();
subplot(1,2,1);
% transform with MATLAB built-in function imwarp.
out_image1 = im2uint8(imwarp(I2, inv_T));
imshow(out_image1);
title('Transformation with built-in imwarp');
subplot(1,2,2);
% transform with our image_transform.m.
out_image2 = im2uint8(image_transform(I2, inv_T));
imshow(out_image2);
title('Transformation with image\_transform');
%sgtitle('Image transformation from boat2 to boat1');
saveas(fig1,'./results/q1_3_warptransform.eps','epsc');

% comparison of before and after transformation.
out_image3 = im2uint8(I2);
size_image2 = size(out_image2);
out_image3 = [out_image3 zeros(680,size_image2(2)-850)];
out_image3 = [out_image3; zeros(size_image2(1)-680, size_image2(2))];

fig2 = figure();
Is = cat(4, out_image3, out_image2 );
mnt = montage(Is, 'Size', [1 2]);
title('Comparison of before and after image transformation of boat2');
hold on
%p1_image = matching_points([1 2],:);
%p2_image = matching_points([3 4],:);
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
saveas(fig2,'./results/q1_3_beforeafter.eps','epsc');

% transform from boat1 to boat2 and boat2 to boat 1.
fig3 = figure();
subplot(1,2,1);
% transform from boat1 to boat2.
out_image4 = im2uint8(imwarp(I1, T));
imshow(out_image4);
title('boat1 to boat2');
subplot(1,2,2);
% transform from boat2 to boat1.
imshow(out_image2);
title('boat2 to boat1');
%sgtitle('Image transformation from boat2 to boat1');
saveas(fig1,'./results/q1_3_b1b2b2b1.eps','epsc');
