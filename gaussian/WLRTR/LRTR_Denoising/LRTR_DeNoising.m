function [E_Img]   =  LRTR_DeNoising( N_Img, O_Img, Par )

E_Img            = N_Img;                                                        % Estimated Image
[Height, Width, Band]  = size(E_Img);   
TotalPatNum      = (Height-Par.patsize+1)*(Width-Par.patsize+1);                 % Total Patch Number in the image
Average          = mean(N_Img,3);                                                % Calculate the average band for fast spatial non-local searching
[Neighbor_arr, Num_arr, Self_arr] =	NeighborIndex(Average, Par);                 % PreCompute the all the patch index in the searching window 
for iter = 1 : Par.Iter        
    Average             =   mean(E_Img,3);         
    [CurPat, Mat, Sigma_arr]	=	Im2Patch( E_Img, N_Img, Average, Par );       % image to patch and estimate local noise variance 
    
    if (mod(iter-1,2)==0)
%         Par.patnum = Par.patnum-10;                                             % Lower Noise level, less NL patches
        NL_mat  =  Block_matching(Mat, Par, Neighbor_arr, Num_arr, Self_arr);     % Caculate Non-local similar patches for each
        if(iter==1)
            Sigma_arr = Par.nSig * ones(size(Sigma_arr));                         % First Iteration use the input noise parameter
        end
    end
     tic
     [EPat, W]    =  TPatEstimation( NL_mat, Self_arr, Sigma_arr, CurPat, Par);   % Estimate the spatial patches
     toc
     [S_Img, S_Wei]   =  Patch2Im( EPat, W, Par.patsize, Height, Width, Band );
     E_Img = S_Img./S_Wei;
     PSNR  = csnr( O_Img, E_Img, 0, 0 );
     SSIM  = cal_ssim( O_Img, E_Img, 0, 0 );
    fprintf( 'Iter = %2.3f, PSNR = %2.2f, SSIM = %2.3f, NoiseLevel = %2.3f \n', iter, PSNR, SSIM, sum(Sigma_arr)/TotalPatNum);
end
return;


