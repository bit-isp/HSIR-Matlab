addpath(genpath('LRMR'));
addpath(genpath('../../lib'));

load('../../data/icvl_512_stripe/bulb_0822-0903.mat')

[H W C] = size(gt);

% ==== run ====

tic

if size(input, 3) > 100
    r = 7;
    slide = 20;
    s = 0.1;
    stepsize = 8;
else
    % ICVL
    r = 2;
    slide = 30;
    s = 0.05;
    stepsize = 4;
    % CAVE
    % r = 3;
    % slide = 20;
    % s = 0.00;
    % stepsize = 4;
end
output = LRMR_HSI_denoise(input, r, slide, s, stepsize);

runtime = toc;

% ==== evaluate ====

[psnr, ssim, sam] = eevaluate(gt, output, H, W);

imwrite(gt(:, :, 20), 'gt_gray.png');
imwrite(hsi2rgb(gt), 'gt_color.png');
imwrite(output(:, :, 20), 'gray.png');
imwrite(hsi2rgb(output), 'color.png');

fprintf('[LRMR] MPSNR=%5.4f MSSIM=%5.4f SAM=%5.4f Time=%5.4f\n', psnr, ssim, sam, runtime)
