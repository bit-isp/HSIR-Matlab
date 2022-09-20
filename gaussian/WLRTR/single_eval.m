addpath('LRTR_Denoising');
addpath(genpath('../../utils'));

load('../../data/icvl_512_50/bulb_0822-0909.mat')

[H W C] = size(gt);
sigma = 50.0/255;

% ==== run ====

tic

Par = ParSet(sigma);
[output] = LRTR_DeNoising(input*255, gt*255, Par); %LRTA denoisng function
output = output / 255;

runtime = toc;

% ==== evaluate ====

[psnr, ssim, sam] = eevaluate(gt, output, H, W);

imwrite(gt(:, :, 20), 'gt_gray.png');
imwrite(hsi2rgb(gt), 'gt_color.png');
imwrite(output(:, :, 20), 'gray.png');
imwrite(hsi2rgb(output), 'color.png');

fprintf('[WLRTR] MPSNR=%5.4f MSSIM=%5.4f SAM=%5.4f Time=%5.4f\n', psnr, ssim, sam, runtime)
