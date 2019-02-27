close all
clear all

image2 = imread('images/image2.jpg');
fig = figure(1);

subplot(2, 2, 1)
imshow(image2)
title('Original image')
for i = 1 : 3
    subplot(2, 2, i + 1)
    image2_filtered = compute_LoG(image2, i);
    imshow(image2_filtered)
    title(['Method ', num2str(i)])
end
saveas(fig, './results/log3_comp.eps', 'epsc')