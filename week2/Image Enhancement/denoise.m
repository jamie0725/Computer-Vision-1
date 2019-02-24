function [ imOut ] = denoise( image, kernel_type, varargin)

switch kernel_type
    case 'box'
        %fprintf('Not implemented\n')
        imOut = imboxfilt(image, varargin{1});
    case 'median'
        %fprintf('Not implemented\n')
        imOut = medfilt2(image, [varargin{1} varargin{2}]);
    case 'gaussian'
        %fprintf('Not implemented\n')
        h = gauss2D(varargin{1},varargin{2});
        %imOut = imfilter(image, h);
        imOut = conv2(h,im2double(image));
end
end
