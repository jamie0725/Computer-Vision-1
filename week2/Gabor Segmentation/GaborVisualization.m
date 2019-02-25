sigma_default = 6;
theta_default = pi/4;
lambda_default = 10;
phi_default = 0;
gamma_default = 1;

theta_cells = [0, pi/6, pi/4, pi/3, pi/2];
theta_strs = {"0", "$\frac{\pi}{6}$", "$\frac{\pi}{4}$", "$\frac{\pi}{3}$", "$\frac{\pi}{2}$"};
sigma_cells = [6, 8, 10, 15, 20];
gamma_cells = [0.3, 0.5, 1.0, 2, 3];

fig=figure();

j=1;
% subplot(1,2, 1);

% imshow(ones(20,20));
% subplot(1,2, 2);

% imshow(zeros(20,20));


for i=1:5
    theta = theta_cells(i);
    myGabor = createGabor(sigma_default, theta, lambda_default, phi_default, gamma_default);
    myGabor_real = myGabor(:,:,1);
    subplot(3, 5, i-1+(j-1)*5+1); imshow(myGabor_real,[]);
    titleT = ['$\theta$ = ', char(theta_strs{i})];
    title(titleT,'interpreter','latex');
end

j=j+1;
for i=1:5
    sigma = sigma_cells(i);
    myGabor = createGabor(sigma, theta_default, lambda_default, phi_default, gamma_default);
    myGabor_real = myGabor(:,:,1);
    subplot(3, 5, i-1+(j-1)*5+1); imshow(myGabor_real,[]);
    titleT = ['$\sigma$ = ', num2str(sigma)];
    title(titleT,'interpreter','latex');
end

j=j+1;
for i=1:5
    gamma = gamma_cells(i);
    myGabor = createGabor(gamma_default, theta_default, lambda_default, phi_default, gamma);
    myGabor_real = myGabor(:,:,1);
    subplot(3, 5, i-1+(j-1)*5+1); imshow(myGabor_real,[]);
    titleT = ['$\gamma$ = ', num2str(gamma)];
    title(titleT,'interpreter','latex');
end

saveas(fig, "./gabor_vis.eps", "epsc")