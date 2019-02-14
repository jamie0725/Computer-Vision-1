%%% 1 %%%
I = imread('cameraman.tif');
[m, n] = size(I);
centerCol = floor(n/2);
left = I(1:end,1:centerCol);
right = I(1:end,centerCol+1:end);
J = cat(2,right,left);
figure(1), imshow(I);
figure(2), imshow(J);
%%% 2 %%%
I = imread('peppers.png');
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);
J = cat(3,B,G,R);
subplot(2,1,1)
imshow(I)
subplot(2,1,2)
imshow(J)
%%% 3 %%%
A = randi(100,100);
B = conv2(A, ones(3)/9, 'valid');
