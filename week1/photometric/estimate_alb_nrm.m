function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal 


[h, w, n] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|
warning('off', 'MATLAB:rankDeficientMatrix')
for i_h = 1:h
    for i_w = 1:w
        i = reshape(image_stack(i_h, i_w, :), [] , 1);           
%         if any(i) == false
%             albedo(i_h, i_w) = 0;
%             normal(i_h, i_w, :) = [0, 0, 1];
%             continue
%         end
        if shadow_trick == true
            scriptI = diag(i);
            A = scriptI * scriptV;
            B =  scriptI * i;            
            [g, ~] = linsolve(A, B);            
%             g = A \ B;
        else
            [g, ~] = linsolve(scriptV, i);
%         g = scriptV \ i;
        end                       
        
        norm_g = norm(g);
        albedo(i_h, i_w) = norm_g;
        normal(i_h, i_w, :) = g / norm_g;
    end
end


% =========================================================================

end

