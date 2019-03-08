function result_img = image_transform(prev_img, T)
%imageTransform - transfrom the `prev_img` using the transfromation specified by `m`, and `b`.
%
% Syntax: result_img = imageTransform(prev_img, m, b)
%
% Long description

[H, W, C] = size(prev_img);

[x_grid, y_grid] = meshgrid(1:W, 1:H);
% apply the affine transformation on the grid
[new_x_grid,new_y_grid] = transformPointsForward(T,x_grid,y_grid);
% new_x_grid = T(1,1).*x_grid+T(1, 2).*y_grid+T(3,1);
% new_y_grid = T(2,1).*x_grid+T(2, 2).*y_grid+T(3,2);

min_new_x = min(min(new_x_grid));
min_new_y = min(min(new_y_grid));

% get the new grid by setting the leftmost and upmost point to be 
% at the left and up side of the image grid
new_x_grid = new_x_grid-min_new_x+1;
new_y_grid = new_y_grid-min_new_y+1;

% set the rightmost and downmost coordinate to be W and H respectively
new_H = max(max(new_x_grid));
new_W = max(max(new_y_grid));

result_img = zeros(ceil(new_H), ceil(new_W), C);
% size(result_img);
for i = 1:H
    for j = 1:W
        img_val = prev_img(i, j, :);
        y_ind = round(new_y_grid(i, j));
        x_ind = round(new_x_grid(i, j));
        result_img(x_ind, y_ind, :) = img_val;
    end
end
result_img = result_img';
end