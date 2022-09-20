function [ EPat, W ] = TPatEstimation( NL_mat, Self_arr, Sigma_arr, CurPat, Par)
        EPat = zeros(size(CurPat));
        W    = zeros(size(CurPat));
        for  i      =  1 : length(Self_arr)                                   % For each keypatch group
            Temp    =   CurPat(:, NL_mat(1:Par.patnum,i),:);                  % Non-local similar patches to the keypatch
            M_Temp  =   repmat(mean( Temp, 2 ),1,Par.patnum);
            Temp    =   Temp - M_Temp;
            E_Temp	=   TWNNM(Temp, Par.c1, Sigma_arr(Self_arr(i)));          % TWNNM Estimation
            E_Temp  =   E_Temp + M_Temp;
            EPat(:,NL_mat(1:Par.patnum,i),:)  = EPat(:,NL_mat(1:Par.patnum,i),:) + E_Temp;      
            W(:,NL_mat(1:Par.patnum,i),:)     = W(:,NL_mat(1:Par.patnum,i),:) + ones(size(CurPat,1),size(NL_mat(1:Par.patnum,i),1),size(CurPat,3));
        end
end

