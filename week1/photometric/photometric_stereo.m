close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './SphereColor/';   % TODO: get the path of the script
%image_ext = '*.png';

if contains(image_dir, "Color")
    nc = 3;
else
    nc = 1;
end

normals_sum = 0;
for i_c = 1:nc
    [image_stack, scriptV] = load_syn_images(image_dir, i_c);
    if i_c == 1
        [h, w, n] = size(image_stack);           
        albedo = zeros(h, w, nc);
    end
    fprintf('Finish loading %d images.\n\n', n);

    % compute the surface gradient from the stack of imgs and light source mat
    disp('Computing surface albedo and normal map...')
    [albedo_tmp, normals_tmp] = estimate_alb_nrm(image_stack, scriptV);
    albedo(:, :, i_c) = albedo_tmp;
    normals_sum = normals_sum + normals_tmp;
end
normals_sum(isnan(normals_sum)) = 0;

normals = normals_sum ./ nc;
% norm_normals = (normals(:, :, 1).^2 + normals(:, :, 2).^2 + normals(:, :, 3).^2) .^0.5;
% normals = normals ./ norm_normals;
% albedo(isnan(albedo)) = 0;



%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q, 'row' );

%% Display
show_results(albedo, normals, SE);
show_model(albedo, height_map);


%% Face
[image_stack, scriptV] = load_face_images('./yaleB02/');
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.005;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q, 'average' );

show_results(albedo, normals, SE);
show_model(albedo, height_map);

