addpath(genpath('KBR'));
addpath(genpath('../../utils'));

load('../../data/icvl_512_50/bulb_0822-0909.mat')

[H W C] = size(gt);
sigma = sigma/255;
memorySaving = 1;

% ==== run ====

tic

output = KBR_DeNoising(input,sigma, memorySaving)

runtime = toc;

% ==== evaluate ====

[psnr, ssim, sam] = eevaluate(gt, output, H, W);

imwrite(gt(:, :, 20), 'gt_gray.png');
imwrite(hsi2rgb(gt), 'gt_color.png');
imwrite(output(:, :, 20), 'gray.png');
imwrite(hsi2rgb(output), 'color.png');

fprintf('[NGmeet] MPSNR=%5.4f MSSIM=%5.4f SAM=%5.4f Time=%5.4f\n', psnr, ssim, sam, runtime)
