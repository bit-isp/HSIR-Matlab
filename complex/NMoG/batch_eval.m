addpath(genpath('NMoG'));
addpath(genpath('../../utils'));

dir_path = '../../data/icvl_512_stripe/';
save_dir = '../../results/NMoG/icvl_512_stripe/';
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

    imwrite(output(:, :, 20), [save_dir, 'gray/', f, '.png']);
    imwrite(hsi2rgb(output), [save_dir, 'color/', f, '.png']);

    fprintf('[NMoG] MPSNR=%5.4f MSSIM=%5.4f SAM=%5.4f Time=%5.4f\n', psnr, ssim, sam, runtime);
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
