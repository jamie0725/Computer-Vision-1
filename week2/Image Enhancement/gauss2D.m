function G = gauss2D( sigma , kernel_size )
    %% solution
    G_x = gauss1D(sigma, kernel_size);
    G_y = gauss1D(sigma, kernel_size);
    G = G_x' * G_y;
end
