addpath(genpath('NMoG'));
addpath(genpath('../../lib'));

load('../../data/icvl_512_stripe/bulb_0822-0903.mat')

[H W C] = size(gt);

% ==== run ====

tic

if size(input, 3) > 100
    r = 5; % objective rank of low rank component
    param.initial_rank = 30;
    param.rankDeRate = 7;
    param.mog_k = 5;
    param.lr_init = 'SVD';
    param.maxiter = 30;
    param.tol = 1e-4;
    param.display = 0;
else
    r = 3;
    param.initial_rank = 30; % initial rank of low rank component
    param.rankDeRate = 7; % the number of rank reduced in each iteration
    param.mog_k = 3; % the number of component reduced in each band
    param.lr_init = 'SVD';
    param.maxiter = 30;
    param.tol = 1e-3;
    param.display = 0;
end

output = NMoG(input, r, param);
runtime = toc;

% ==== evaluate ====

[psnr, ssim, sam] = eevaluate(gt, output, H, W);

imwrite(gt(:, :, 20), 'gt_gray.png');
imwrite(hsi2rgb(gt), 'gt_color.png');
imwrite(output(:, :, 20), 'gray.png');
imwrite(hsi2rgb(output), 'color.png');

fprintf('[NMoG] MPSNR=%5.4f MSSIM=%5.4f SAM=%5.4f Time=%5.4f\n', psnr, ssim, sam, runtime)
