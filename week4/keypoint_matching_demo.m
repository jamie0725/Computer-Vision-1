clear all
close all

% Set number of matches for visualization.
n_set = 10;
% Read images and convert them into single precision for keypoint_matching.
I1 = single(imread('boat1.pgm'));
I2 = single(imread('boat2.pgm'));
[f1, f2, matches, scores] = keypoint_matching(I1, I2);
% Shuffle all the matches found and pick the first n_set of them.
perms = randperm(size(matches, 2));
matches_plot = matches(:, perms(1:n_set));
% Compute the offset in x direction when for coordinates.
x_offset = size(I1, 2);
% Concatenate images in the 4th dimension for montage plot.
Is = cat(4, uint8(I1), uint8(I2));
fig = figure();
mnt = montage(Is, 'Size', [1 2]);
hold on
for i=1:n_set
    % Extract keypoints coordinates for img1 and img2.
    match_ind1 = matches_plot(1, i);
    match_ind2 = matches_plot(2, i);
    p1 = transpose(f1(1:2, match_ind1));
    p2 = transpose(f2(1:2, match_ind2));
    p2(1) = p2(1) + x_offset;
    % Visualize keypoints and the connections between matches.
    plot(p1(1), p1(2), 'bo', 'LineWidth', 2.5, 'MarkerSize', 15)
    plot(p2(1), p2(2), 'rx', 'LineWidth', 2.5, 'MarkerSize', 15)
    line([p1(1), p2(1)], [p1(2), p2(2)], 'LineWidth', 2.5, 'color',rand(1,3))
end
hold off
saveas(fig, 'results/q1_2.eps', 'epsc');