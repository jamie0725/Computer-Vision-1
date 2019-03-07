function result_img = image_transform(prev_img, m, b)
%imageTransform - transfrom the `prev_img` using the transfromation specified by `m`, and `b`.
%
% Syntax: result_img = imageTransform(prev_img, m, b)
%
% Long description

[H, W, C] = size(prev_img);

% new_shape = (m(0, 0)*W+m(1, 0)*W)
[x_grid, y_grid] = meshgrid(1:W, 1:H);
new_x_grid = m(1,1).*x_grid+m(1, 2).*y_grid+b(1,1);
new_y_grid = m(2,1).*x_grid+m(2, 2).*y_grid+b(1,2);

min_new_x = min(min(new_x_grid));
min_new_y = min(min(new_y_grid));

new_x_grid = new_x_grid-min_new_x+1;
new_y_grid = new_y_grid-min_new_y+1;

new_H = max(max(new_x_grid));
new_W = max(max(new_y_grid));

result_img = zeros(ceil(new_H), ceil(new_W), C);
size(result_img);
for i = 1:H
    for j = 1:W
        img_val = prev_img(i, j, :);
        y_ind = round(new_y_grid(i, j));
        x_ind = round(new_x_grid(i, j));
        result_img(x_ind, y_ind, :) = img_val;
    end
end
end