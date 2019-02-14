%%% 2.1 %%%
x = 0:pi/100:2*pi;
y = sin(x);
figure(1)
plot(x,y)
x = -x;
y = sin(x);
figure(2)
plot(x,y)
x = x .* x;
y = sin(x);
figure(3)
plot(x,y)
%%% 2.2 %%%
x = -2:0.2:2;
y = -2:0.2:2;
[X, Y] = meshgrid(x,y);
Z = X .* exp(-X.^2 - Y.^2);
figure(4)
surf(X, Y, Z)
%%% 2.3 %%%
% 1
x = -4:1:4;
Y = 5 * x .* x .* x - 3 * x .* x + 7 * x - 2;
figure(5)
plot(x,Y)
% 2
x = 0:pi/100:pi;
y = 0:pi/100:pi;
[X, Y] = meshgrid(x,y);
Z = (sin(Y .* Y + X) - cos(Y - X .* X));
figure(6)
surf(X, Y, Z)
