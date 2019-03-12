function [x, points] = RANSAC(f1, f2, matches, N)
% N is the number of loop
sample_number = 10;
max_inliers = 0;
for i = 1:N
    a = randperm(size(matches, 2),sample_number);
    points = (matches(:, a));
    x1 = f1(1,points(1, :)); y1 = f1(2,points(1, :));
    x2 = f2(1,points(2, :)); y2 = f2(2,points(2, :));
    
    A = zeros(2*sample_number, 6);
    b = zeros(2*sample_number, 1);

    for j=1:sample_number
        A(2*j-1:2*j,:) = [x1(j) y1(j) 0 0 1 0; 0 0 x1(j) y1(j) 0 1];
        b(2*j-1:2*j) = [x2(j); y2(j)];
    end

    temp_x = pinv(A) * b;
    
    m = [temp_x(1) temp_x(2);temp_x(3) temp_x(4)];
    t = [temp_x(5);temp_x(6)];
    xy12 = m * [x1; y1] + t;
    x12 = xy12(1,:);
    y12 = xy12(2,:);
    
    count = compute_lnliers(x2, y2, x12, y12);
    if count>max_inliers
        x = temp_x;
        max_inliers = count;
    end
    
end

end

%here we use the Euclidean distance
function count = compute_lnliers(x2, y2, x12, y12)
count = 0;
length = size(x2);
for i = 1:length
    if (((x12(i)-x2(i))^2+(y12(i)-y2(i))^2)<100)
        count = count + 1;
    end
end

end
