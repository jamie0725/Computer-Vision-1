clear all
close all

sigma = 10;
mul = 5;
Z  = fspecial('log', [round(mul * sigma), round(mul * sigma)], sigma);
[X, Y] = meshgrid(1:size(Z,2), 1:size(Z,1));
fig = figure;
mesh(X, Y, Z)
xlabel('x') 
ylabel('y')
zlabel('Amplitude')
axis('square')
saveas(fig, './results/2ode_gauss.eps', 'epsc')