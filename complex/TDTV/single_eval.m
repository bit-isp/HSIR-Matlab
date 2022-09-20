addpath(genpath('TDTV'));
addpath(genpath('../../lib'));

load('../../data/icvl_512_stripe/bulb_0822-0909.mat')

[H W C] = size(gt);
sigma = 50.0/255;

% ==== run ====

tic

if size(input, 3) > 100
    output = LRTDTV(input, 1, 10, [ceil(0.8 * hsi_sz(1)), ceil(0.8 * hsi_sz(2)), 10]);
else
    output = LRTDTV(input, 1, 10, [ceil(0.1 * hsi_sz(1)), ceil(0.1 * hsi_sz(2)), 3]);
end

runtime = toc;

% ==== evaluate ====

[psnr, ssim, sam] = eevaluate(gt, output, H, W);

imwrite(gt(:, :, 20), 'gt_gray.png');
imwrite(hsi2rgb(gt), 'gt_color.png');
imwrite(output(:, :, 20), 'gray.png');
imwrite(hsi2rgb(output), 'color.png');

fprintf('[TDTV] MPSNR=%5.4f MSSIM=%5.4f SAM=%5.4f Time=%5.4f\n', psnr, ssim, sam, runtime)
