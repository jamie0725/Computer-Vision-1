orig_image = imread('images/image1.jpg');
saltpepper_image = imread('images/image1_saltpepper.jpg');
[ PSNR ] = myPSNR( orig_image, saltpepper_image );

gaussian_image = imread('images/image1_gaussian.jpg');
[ PSNR ] = myPSNR( orig_image, gaussian_image );

%saltpepper denoise box
image = figure;
box3_image = denoise(saltpepper_image,'box',3);
subplot(1,3,1);   
imshow(box3_image);
title('box 3*3');
[ PSNR ] = myPSNR( orig_image, box3_image );


box5_image = denoise(saltpepper_image,'box',5);
subplot(1,3,2);
imshow(box5_image);
title('box 5*5');
[ PSNR ] = myPSNR( orig_image, box5_image );


box7_image = denoise(saltpepper_image,'box',7);
subplot(1,3,3);
imshow(box7_image);
title('box 7*7');
[ PSNR ] = myPSNR( orig_image, box7_image );

saveas(image,'saltpepper_box_image.eps','epsc');


%saltpepper denoise median
image = figure;
median3_image = denoise(saltpepper_image,'median',3,3);
subplot(1,3,1);   
imshow(median3_image);
title('median 3*3');
[ PSNR ] = myPSNR( orig_image, median3_image );


median5_image = denoise(saltpepper_image,'median',5,5);
subplot(1,3,2);
imshow(median5_image);
title('median 5*5');
[ PSNR ] = myPSNR( orig_image, median5_image );


median7_image = denoise(saltpepper_image,'median',7,7);
subplot(1,3,3);
imshow(median7_image);
title('median 7*7');
[ PSNR ] = myPSNR( orig_image, median7_image );


saveas(image,'saltpepper_median_image.eps','epsc');

%gaussian denoise box
image = figure;
box3_image = denoise(gaussian_image,'box',3);
subplot(1,3,1);   
imshow(box3_image);
title('box 3*3');
[ PSNR ] = myPSNR( orig_image, box3_image );

box5_image = denoise(gaussian_image,'box',5);
subplot(1,3,2);
imshow(box5_image);
title('box 5*5');
[ PSNR ] = myPSNR( orig_image, box5_image );

box7_image = denoise(gaussian_image,'box',7);
subplot(1,3,3);
imshow(box7_image);
title('box 7*7');
[ PSNR ] = myPSNR( orig_image, box7_image );

saveas(image,'gaussian_box_image.eps','epsc');


%saltpepper denoise median
image = figure;
median3_image = denoise(gaussian_image,'median',3,3);
subplot(1,3,1);   
imshow(median3_image);
title('median 3*3');
[ PSNR ] = myPSNR( orig_image, median3_image );

median5_image = denoise(gaussian_image,'median',5,5);
subplot(1,3,2);
imshow(median5_image);
title('median 5*5');
[ PSNR ] = myPSNR( orig_image, median5_image );

median7_image = denoise(gaussian_image,'median',7,7);
subplot(1,3,3);
imshow(median7_image);
title('median 7*7');
[ PSNR ] = myPSNR( orig_image, median7_image );
saveas(image,'gaussian_median_image.eps','epsc');

close all;

orig_image = imread('images/image1.jpg');
saltpepper_image = imread('images/image1_saltpepper.jpg');
gaussian_image = imread('images/image1_gaussian.jpg');

NUM_OF_ROW = 10;
NUM_OF_COL = 3;
image_gaussian_denoise = figure(2);
PSNR_matrix_gaussian = zeros(NUM_OF_ROW,NUM_OF_COL);
str1='gaussian ';

for i=1:NUM_OF_ROW
    for j=1:NUM_OF_COL
        subplot(NUM_OF_ROW,NUM_OF_COL,NUM_OF_COL*(i-1)+j);
        gaussian_denoise = denoise(gaussian_image,'gaussian',i*0.1,2*j+1);
        imshow(gaussian_denoise);
        str2 = mat2str(i*0.1);
        str3 = ',';
        str4 = mat2str(2*j+1);
        SC=[str1,str2,str3,str4];
        title(SC);
        RemoveSubplotWhiteArea_42(gca, NUM_OF_ROW, NUM_OF_COL, i, j); 
        PSNR_matrix_gaussian(i,j) = myPSNR( orig_image, gaussian_denoise );
    end
end
saveas(image_gaussian_denoise,'image_gaussian_denoise.eps','epsc');

appropriate_image = figure;
gaussian_denoise = denoise(gaussian_image,'gaussian',0.566,3);
imshow(gaussian_denoise);%title('gaussian 0.83,3*3');
saveas(appropriate_image,'gaussian_gaussian566_denoise.eps','epsc');
PSNR = myPSNR( orig_image, gaussian_denoise );
%PSNR_matrix_saltpepper = zeros(NUM_OF_ROW,NUM_OF_COL);
%image_saltpepper_denoise = figure(1);
%for i=1:NUM_OF_ROW
%    for j=1:NUM_OF_COL
%        subplot(NUM_OF_ROW,NUM_OF_COL,NUM_OF_COL*(i-1)+j);
%        saltpepper_denoise = denoise(saltpepper_image,'gaussian',i*0.3,2*j-1);
%        imshow(saltpepper_denoise);
%        %title('median 7*7');
%        PSNR_matrix_saltpepper(i,j) = myPSNR( orig_image, saltpepper_denoise );
%    end
%end
%saveas(image_saltpepper_denoise,'image_saltpepper_denoise.eps','epsc');

function [] = RemoveSubplotWhiteArea_42(gca, sub_row, sub_col, current_row, current_col)
% 设置OuterPosition
sub_axes_x = current_col*1/sub_col - 1/sub_col;
sub_axes_y = 1-current_row*1/sub_row; % y是从上往下的
sub_axes_w = 1/sub_col;
sub_axes_h = 1/sub_row;
set(gca, 'OuterPosition', [sub_axes_x, sub_axes_y, sub_axes_w, sub_axes_h]); % 重设OuterPosition

% TightInset的位置
inset_vectior = get(gca, 'TightInset');
inset_x = inset_vectior(1);
inset_y = inset_vectior(2);
inset_w = inset_vectior(3);
inset_h = inset_vectior(4);

% OuterPosition的位置
outer_vector = get(gca, 'OuterPosition');
pos_new_x = outer_vector(1) + inset_x; % 将Position的原点移到到TightInset的原点
pos_new_y = outer_vector(2) + inset_y;
pos_new_w = outer_vector(3) - inset_w - inset_x; % 重设Position的宽
pos_new_h = outer_vector(4) - inset_h - inset_y; % 重设Position的高

% 重设Position
set(gca, 'Position', [pos_new_x, pos_new_y, pos_new_w, pos_new_h]);
end