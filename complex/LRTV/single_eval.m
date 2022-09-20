addpath(genpath('LRTV'));
addpath(genpath('../../lib'));

load('../../data/icvl_512_stripe/bulb_0822-0909.mat')

[H W C] = size(gt);
sigma = 50.0/255;

% ==== run ====

tic

if size(input, 3) > 100
    tau = 0.015;
    lambda = 20 / sqrt(hsi_sz(1) * hsi_sz(2));
    rank = 10;
else
    %         ICVL
    tau = 0.01;
    lambda = 10 / sqrt(hsi_sz(1) * hsi_sz(2));
    rank = 5;
end

output = LRTV(input, tau, lambda, rank);

runtime = toc;

% ==== evaluate ====

[psnr, ssim, sam] = eevaluate(gt, output, H, W);

imwrite(gt(:, :, 20), 'gt_gray.png');
imwrite(hsi2rgb(gt), 'gt_color.png');
imwrite(output(:, :, 20), 'gray.png');
imwrite(hsi2rgb(output), 'color.png');

fprintf('[LRTV] MPSNR=%5.4f MSSIM=%5.4f SAM=%5.4f Time=%5.4f\n', psnr, ssim, sam, runtime)
