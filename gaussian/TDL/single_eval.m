addpath(genpath('tensor_dl'));
addpath(genpath('../../lib'));

load('../../data/icvl_512_50/bulb_0822-0909.mat')

[H W C] = size(gt);
sigma = 50.0/255;

% ==== run ====

tic

vstbmtf_params.peak_value = 1;
vstbmtf_params.nsigma = sigma;
output = TensorDL(input, vstbmtf_params);

runtime = toc;

% ==== evaluate ====

[psnr, ssim, sam] = eevaluate(gt, output, H, W);

imwrite(gt(:, :, 20), 'gt_gray.png');
imwrite(hsi2rgb(gt), 'gt_color.png');
imwrite(output(:, :, 20), 'gray.png');
imwrite(hsi2rgb(output), 'color.png');

fprintf('[TDL] MPSNR=%5.4f MSSIM=%5.4f SAM=%5.4f Time=%5.4f\n', psnr, ssim, sam, runtime)
