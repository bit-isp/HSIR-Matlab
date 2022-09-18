addpath('NGmeet');
addpath('assess_fold');
addpath('../utils');

dir_path = '../../data/icvl_512_50/';
save_dir = '../../results/NGmeet/icvl_512_50/';
files = dir([dir_path, '*.mat']);
len = length(files);

mkdir(save_dir, 'color')
mkdir(save_dir, 'gray')
fileID = fopen([save_dir, 'log.json'], 'w');

fprintf(fileID, '{\n');
fprintf(fileID, '"detail": {\n');

total_psnr = 0;
total_ssim = 0;
total_sam = 0;
total_time = 0;

for i = 1:len
    file = files(i);
    name = file.name;
    [p, f, e] = fileparts(name);
    full_path = [dir_path, name];
    load(full_path); % input, gt, sigma
    fprintf("[%d|%d]: process %s\n", i, len, name)

    [H W C] = size(gt);
    sigma = sigma/255;

    % ==== run ====

    tic

    Par = ParSetH(255 * sigma, C);
    [output] = NGmeet_DeNoising(255 * input, 255 * gt, Par); 
    output = output / 255;

    runtime = toc;

    % ==== evaluate ====

    [psnr, ssim, sam] = eevaluate(gt, output, H, W);

    imwrite(output(:, :, 20), [save_dir, 'gray/', f, '.png']);
    imwrite(hsi2rgb(output), [save_dir, 'color/', f, '.png']);

    fprintf('[NGmeet] MPSNR=%5.4f MSSIM=%5.4f SAM=%5.4f Time=%5.4f\n', psnr, ssim, sam, runtime);
    fprintf(fileID, '\t"%s": { "MPSNR":%5.4f, "MSSIM":%5.4f, "SAM":%5.4f, "Time":%5.4f}', f, psnr, ssim, sam, runtime);
    if i ~= len
        fprintf(fileID, ',\n');
    end
    total_psnr = total_psnr + psnr;
    total_ssim = total_ssim + ssim;
    total_sam = total_sam + sam;
    total_time = total_time + runtime;
end

fprintf(fileID, '},\n');
fprintf(fileID, '\t"avg": { "MPSNR":%5.4f, "MSSIM":%5.4f, "SAM":%5.4f, "Time":%5.4f\n}', total_psnr / len, total_ssim / len, total_sam / len, total_time / len);
fprintf(fileID, '}');
fclose(fileID);
