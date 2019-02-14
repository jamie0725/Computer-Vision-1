%%% 1.1 %%%
s1 = 5; 
s2 = 5 
s3 = 6.02 * 10^23 
s4 = log(exp(4)) % = 4
s5 = sqrt(s4) % = 2
s6 = s2 / s5 % = 2.5
%%% 1.2 %%%
v1 = [1, 2, 3, 4]
v2 = [1; 2; 3; 4]
v3 = v2' % = v1
v4 = 0:2:10 % 0 2 4 6 8 10
v5 = 10:-2:0 % 10 8 6 4 2 0
v6 = 'I am a string'
%%% 1.3 %%%
m1 = ones(10,10) * 3
m1 = zeros(10,10) + 3
m2 = eye(5)
m3 = diag([1, 2, 3, 33, 333])
m4 = [10, 20; 30, 40]
m5 = [2, 4; 3, 5]
m6 = m4 / m5 % [5, 0; -15, 20]
m7 = m4 ./ m5 % [5, 5; 10, 8]
m8 = det(m7) % = -10
m9 = m7' % [5, 10; 5 8]
m10 = m9(:) % [5; 5; 10; 8]
%%% 1.4 %%%
A = [1, 2, 3; 4, 5, 6; 7, 8, 9]
B =[10, 20, 30; 40, 50, 60; 70, 80, 90]
i1 = [A, B; B, A]
i2 = A(1:2,1) % [1; 4]
i3 = A(:,1) % [1; 4; 7]
A(1,:) = B(2,:) 
A(2,1) = 33
B(5,5) = 55
i4 = B(1:2:5) % [10, 70, 0]
B(1:3,:) = B(1:3,:) + 100
i5 = B(end) % = 55
%%% 1.5 %%%
% 1
vv = 10:2:49
% 2
X = [2, 3, 1, 9]
X = X + 16
sum(X) % = 79
Y = sort(X, 'ascend') % 17 18 19 25
sum(X(1:2:end)) % = 35
% 3
X = [5; 3; 1; 8]
Y = [4 1 7 5]
power(X,Y') % 625, 3, 1, 32768
X ./ Y' % 1.25, 3, 0.1429, 1.6
% 4
t = 1:0.1:2.0
log(2 + t + t.*t) % 1.3863    1.4609    1.5347    ...
exp(1 + cos(3*t)) % 1.0101    1.0126    1.1088    ...
cos(t).*cos(t) + sin(t).*sin(t) % 1.0000    1.0000    1.0000    ...
atan(t) %  0.7854    0.8330    0.8761 ...
% 5
x = [3, 1, 5, 7, 9, 2, 6]
x(3) % 5
x(1:7) %  3 1 5 7 9 2 6
x(1:end) % 3 1 5 7 9 2 6
x(1:end-1) % 3 1 5 7 9 2
x(6:-2:1) % 2 7 1
x([1, 6, 2, 1, 1]) % 3 2 1 3 3
% 6
A = [2, 4, 1; 6, 7, 2; 3, 5, 9]
x = A(1,:)
y = A(2:end,:)
sum(A,1)
sum(A,2)
mean(A(:))
std(A(:))
% 7 a f g works, other does not because of dimension mismatch
% 8 
x = [1, 5, 2, 8, 9, 0, 1]
y = [5, 2, 2, 6, 0, 0, 2]
x < y % 1     0     0     0     0     0     1
y <= x % 0     1     1     1     1     1     0
x ~= y % 1     1     0     1     1     0     1
x == y % 0     0     1     0     0     1     0
x | y % 1     1     1     1     1     0     1
x & y % 1     1     1     1     0     0     
% 9
A = [2, 7, 9, 7; 3, 1, 5, 6; 8, 1, 2, 5]
A(:, [1 4]) % get all rows together with 1st and 4th columns
A([2 3], [3 1]) % get 2nd row with columns 3 and 1 AND get 3rd row with columns 3 and 1
A(:) % get all the elements
reshape(A,2,6) % reshape matrix A by 2x6
flipud(A) % flip array in up/down direction along the first dimension
fliplr(A) % Flip array in left/right direction along the second dimension
size(A) % 3 x 4
max(max(A)) % = 9
