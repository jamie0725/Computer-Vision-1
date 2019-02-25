orig_image = imread('images/image1.jpg');
saltpepper_image = imread('images/image1_saltpepper.jpg');
[ PSNR ] = myPSNR( orig_image, saltpepper_image );
%PSNR

gaussian_image = imread('images/image1_gaussian.jpg');
[ PSNR ] = myPSNR( orig_image, gaussian_image );
%PSNR

%denoise box
box3_image = denoise(saltpepper_image,'box',3);
fig_box3 = imshow(box3_image);
saveas(fig_box3,'box3_image.eps','epsc');

box5_image = denoise(saltpepper_image,'box',5);
fig_box5 = imshow(box5_image);
saveas(fig_box5,'box5_image.eps','epsc');

box7_image = denoise(saltpepper_image,'box',7);
fig_box7 = imshow(box7_image);
saveas(fig_box7,'box7_image.eps','epsc');

%denoise median
median3_image = denoise(saltpepper_image,'median',3,3);
fig_median3 = imshow(median3_image);
saveas(fig_median3,'median3_image.eps','epsc');

median5_image = denoise(saltpepper_image,'median',5,5);
fig_median5 = imshow(median5_image);
saveas(fig_median5,'median5_image.eps','epsc');

median7_image = denoise(saltpepper_image,'median',7,7);
fig_median7 = imshow(median7_image);
saveas(fig_median7,'median7_image.eps','epsc');


gauss_image = denoise(saltpepper_image,'gaussian',1,3);
fig_gauss = imshow(gauss_image);
saveas(fig_gauss,'guass_image2.eps','epsc');