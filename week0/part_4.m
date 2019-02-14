function [ result ] = mySum(num1, num2)
%Returns the sum of the input arguments.
result = num1 + num2;
end

function [meanValue, medianValue, stdValue] = myFunc1(inputVector)
meanValue = mean(inputVector(:));
medianValue = median(inputVector(:));
stdValue = std(inputVector(:));
end

function myFunc2(I)
J = rgb2gray(I);
figure
imshow(J)
end
