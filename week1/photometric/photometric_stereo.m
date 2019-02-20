close all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
<<<<<<< HEAD
image_dir = './SphereGray5/';   % TODO: get the path of the script
=======
image_dir = './MonkeyGray/';   % TODO: get the path of the script
>>>>>>> 446d0a782eed8d82337b9d7d644a11bfe86a573e
%image_ext = '*.png';

% Initialize parameters.
shadow_trick_1 = true;
path_1 = 'column';
threshold_1 = 0.005;

shadow_trick_2 = false;
path_2 = 'average';
threshold_2 = 0.005;

% Case distinction for gray and color images.
if contains(image_dir, 'Color')
    nc = 3;
else
    nc = 1;
end

normals_sum = 0;
for i_c = 1:nc
    % Split the images into separate channels and treat them individually.
    [image_stack, scriptV] = load_syn_images(image_dir, i_c, 1);
    % Initialize albedo for the first channel.
    if i_c == 1
        [h, w, n] = size(image_stack);           
        albedo = zeros(h, w, nc);
    end
    fprintf('Finish loading %d images.\n\n', n);

    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo_tmp, normals_tmp] = estimate_alb_nrm(image_stack, scriptV, shadow_trick_1);
    albedo(:, :, i_c) = albedo_tmp;
    % Get rid of NaN's and sum up the normals for computing the mean later.
    normals_tmp(isnan(normals_tmp)) = 0;
    normals_sum = normals_sum + normals_tmp;
end
albedo(isnan(albedo)) = 0;
% Take the mean of the normal and normalize.
normals = normals_sum ./ nc;
norm_normals = (normals(:, :, 1).^2 + normals(:, :, 2).^2 + normals(:, :, 3).^2) .^0.5;
normals = normals ./ norm_normals;



%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

SE(SE <= threshold_1) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold_1)));

%% compute the surface height
height_map = construct_surface( p, q, path_1 );

%% Display
gen_fig_1 = show_results(albedo, normals, SE);
hm_fig_1 = show_model(albedo, height_map);
% Save figures.
saveas(gen_fig_1, strcat('./results/', image_dir(3:length(image_dir) - 1), '_gen_', path_1(1:3), '_',string(shadow_trick_1), '.eps'), 'epsc')
saveas(hm_fig_1, strcat('./results/', image_dir(3:length(image_dir) - 1), '_hm_', path_1(1:3), '_',string(shadow_trick_1), '.eps'), 'epsc')


%% Face
[image_stack, scriptV] = load_face_images('./yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, shadow_trick_2);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

SE(SE <= threshold_2) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold_2)));

%% compute the surface height
height_map = construct_surface( p, q,  path_2 );

%% Display
gen_fig_2 = show_results(albedo, normals, SE);
hm_fig_2 = show_model(albedo, height_map);
% Save figures.
saveas(gen_fig_2, strcat('./results/', 'Yale', '_gen_', path_2(1:3), '_', string(shadow_trick_2), '_incl', '.eps'), 'epsc')
% saveas(hm_fig_2, strcat('./results/', 'Yale', '_hm_', path_2(1:3), '_', string(shadow_trick_2), '_incl', '.eps'), 'epsc')
saveas(hm_fig_2, strcat('./results/', 'Yale', '_hm_', path_2(1:3), '_', string(shadow_trick_2), '_incl', '.png'))
view(0, 0)
saveas(hm_fig_2, strcat('./results/', 'Yale', '_hm_', path_2(1:3), '_', string(shadow_trick_2), '_YZ_incl', '.eps'), 'epsc')
view(0, 90)
saveas(hm_fig_2, strcat('./results/', 'Yale', '_hm_', path_2(1:3), '_', string(shadow_trick_2), '_XZ_incl', '.eps'), 'epsc')