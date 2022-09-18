function [psnr, ssim, sam] = eevaluate(OriData3, output_image, M, N)
    p = size(OriData3, 3);

    PSNRvector = zeros(1, p);
    for i = 1:1:p
        J = 255 * OriData3(:, :, i);
        I = 255 * output_image(:, :, i);
        PSNRvector(1, i) = PSNR(J, I, M, N);
    end
    psnr = mean(PSNRvector);


    SSIMvector = zeros(1, p);
    for i = 1:1:p
        J = 255 * OriData3(:, :, i);
        I = 255 * output_image(:, :, i);
        [SSIMvector(1, i), ssim_map] = SSIM(J, I);
    end
    ssim = mean(SSIMvector);

    sum1 = 0.0;
    for i = 1:M;
        for j = 1:N;
            T = OriData3(i, j, :);
            T = T(:)';
            H = output_image(i, j, :);
            H = H(:)';
            sum1 = sum1 + SAM(T, H);
        end
    end
    sam = sum1 / (M * N);
