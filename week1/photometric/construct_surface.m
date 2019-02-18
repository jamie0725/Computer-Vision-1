function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        
        % Compute the height_map for the first row.
        for i_w = 2:w
            height_map(1, i_w) = height_map(1, i_w - 1) + p(1, i_w);
        end
        
        for i_h = 2:h
            % Compute the height map for the leftmost column.
           height_map(i_h, 1) = height_map(i_h - 1, 1) + q(i_h, 1);
           for i_w = 2:w
               % Compute the height map for the rest.
               height_map(i_h, i_w) = height_map(i_h, i_w - 1) + p(i_h, i_w);
           end
        end
       

       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        % Compute the height map for the first column.
        for i_h = 2:h
            height_map(i_h, 1) = height_map(i_h - 1, 1) + q(i_h, 1);
        end
        
        for i_w = 2:w
            % Compute the height map for the upmost row.
           height_map(1, i_w) = height_map(1, i_w - 1) + p(1, i_w);
           for i_h = 2:h
               % Compute the height map for the rest.
               height_map(i_h, i_w) = height_map(i_h - 1, i_w) + q(i_h, i_w);
           end
        end
       

        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        % Compute the height maps via column-major and row-major and take
        % the average.
        height_map_1 = zeros(h, w);
        height_map_2 = zeros(h, w);
        for i_w = 2:w
            height_map_1(1, i_w) = height_map_1(1, i_w - 1) + p(1, i_w);
        end
        for i_h = 2:h
           height_map_1(i_h, 1) = height_map_1(i_h - 1, 1) + q(i_h, 1);
           for i_w = 2:w
               height_map_1(i_h, i_w) = height_map_1(i_h, i_w - 1) + p(i_h, i_w);
           end
        end

        for i_h = 2:h
            height_map_2(i_h, 1) = height_map_2(i_h - 1, 1) + q(i_h, 1);
        end
        for i_w = 2:w
           height_map_2(1, i_w) = height_map_2(1, i_w - 1) + p(1, i_w);
           for i_h = 2:h
               height_map_2(i_h, i_w) = height_map_2(i_h - 1, i_w) + q(i_h, i_w);
           end
        end        
        height_map = (height_map_1 + height_map_2) / 2;
        % =================================================================
end


end

