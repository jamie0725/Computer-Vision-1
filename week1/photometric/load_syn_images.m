function [ image_stack, scriptV ] = load_syn_images( image_dir, channel )
%LOAD_SYN_IMAGES read from directory image_dir all files with extension png
%   image_dir: path to the image directory
%   nchannel: the image channel to be loaded, default = 1
%
%   image_stack: all images stacked along the 3rd channel
%   scriptV: light directions

files = dir(fullfile(image_dir, '*.png'));
nfiles = length(files);

if nargin == 1
    channel = 1;
end

image_stack = 0;
V = 0;
Z = 0.5;

i_img = 1;
for i = 1:nfiles

    % read input image
    im_org = imread(fullfile(image_dir, files(i).name));
%     if channel == 1
%         im = im(:, :, channel);
%     end
    
    if i_img == 1
        % stack at third dimension
        [h, w, ~] = size(im_org);
        image_stack = zeros(h, w, nfiles * channel, 'uint8');
        fprintf('Image size (HxW): %dx%d\n', h, w);
        V = zeros(nfiles * channel, 3, 'double');
    end
    
    % read light direction from image name
    name = files(i).name(8:end);
    m = strfind(name,'_')-1;
    X = str2double(name(1:m));
    n = strfind(name,'.png')-1;
    Y = str2double(name(m+2:n));
    
    for i_c = 1:channel
        im = im_org(:, :, i_c);       
        image_stack(:, :, i_img) = im;       
        V(i_img, :) = [-X, Y, Z];
        i_img = i_img + 1;
    end   
            
end

% normalization
min_val = double(min(image_stack(:)));
max_val = double(max(image_stack(:)));
image_stack = (double(image_stack) - min_val) / (max_val - min_val);

normV = sqrt(sum(V.^2, 2));
scriptV = bsxfun(@rdivide, V, normV);

end

