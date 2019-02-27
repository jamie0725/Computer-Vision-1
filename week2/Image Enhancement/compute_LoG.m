function imOut = compute_LoG(image, LOG_type)
kernel_size = 5;
sigma = 0.5;
k = 1.6;
switch LOG_type
    case 1
        %method 1
        gauss_kernel = gauss2D(sigma, kernel_size);
        imOut = conv2(image, gauss_kernel);
        lapl = fspecial('laplacian');
        imOut = conv2(imOut, lapl);

    case 2
        %method 2
        log_kernel = fspecial('log');
        imOut = conv2(image, log_kernel);
    case 3
        %method 3
        gauss_kernel_1 = gauss2D(sigma, kernel_size);
        gauss_kernel_2 = gauss2D(sigma * k, kernel_size);
        approx_log = gauss_kernel_2 - gauss_kernel_1;
        imOut = conv2(image, approx_log);
end
end

