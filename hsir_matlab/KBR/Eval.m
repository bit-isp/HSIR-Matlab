clc;
clear;close all;
% addpath(genpath('lib'));

dir_path = '/home/laizeqiang/Desktop/lzq/projects/hyper-pnp/DPIR/testsets/eccvdata/icvl_512_70/';
files = dir([dir_path, '*.mat']);

memorySaving = 1;  
methodname = 'KBR';

for i = 42:length(files)
    file = files(i);
    name = file.name;
    full_path = [dir_path, name];
    load(full_path);
    fprintf("%d: process %s, sigma=%f\n", i, name, sigma/255)

    Omsi = gt;
    noisy_msi=input;
    sigma = sigma/255;

    tic;
    Re_msi = KBR_DeNoising(noisy_msi,sigma, memorySaving);%,Omsi);
    Time = toc;
    [psnr, ssim, fsim, ergas, msam] = MSIQA(Omsi * 255, Re_msi * 255);
    disp([methodname, ' done in ' num2str(Time), ' s.'])
    disp([methodname, ' PSNR ' num2str(psnr), ' .'])

    save_path = ['log/70/', name];
    save(save_path, 'Re_msi', 'gt')
end