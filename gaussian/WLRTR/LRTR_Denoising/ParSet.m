function  [par]=ParSet(nSig)

%% Patch-based Iteration Parameters
par.nSig        =   nSig;                               % Variance of the noise image
par.SearchWin   =   30;                                 % Non-local patch searching window
par.c1          =   0.04;                               % Constant num for multispectral image

% par.c1          =   40*sqrt(2);                         % Constant num for multispectral image
par.c1          =   5*sqrt(2);                         % Constant num for multispectral image
par.c2          =   10*sqrt(2);                         % Constant num for multispectral image
par.c3          =   110*sqrt(3);                         % Constant num for multispectral image



% par.c1          =   0.07;                               % Constant num for color image
par.Iter_Inner = 3;
par.Thresh     = 0.1;
% %% Patch and noise Parameters
% if nSig<=10
%     par.patsize       =   6;
%     par.patnum        =   300;
%     par.Iter          =   3;
%     par.lamada        =   0.54;     
% elseif nSig <= 20
%     par.patsize       =   7;
%     par.patnum        =   350;
%     par.Iter          =   4;
%     par.lamada        =   0.56; 
% elseif nSig <= 50
%     par.patsize       =   7;
%     par.patnum        =   400;
%     par.Iter          =   4;
%     par.lamada        =   0.56; 
% else
%     par.patsize       =   9;
%     par.patnum        =   450;
%     par.Iter          =   4;
%     par.lamada        =   0.58; 
% end    
% par.step      =   5;

%% Patch and noise Parameters
if nSig<=10
    par.patsize       =   6;
    par.patnum        =   140;
    par.Iter          =   6;
    par.lamada        =   0.54;     
elseif nSig <= 20
    par.patsize       =   7;
    par.patnum        =   160;
    par.Iter          =   6;
    par.lamada        =   0.56; 
elseif nSig <= 50
    par.patsize       =   7;
    par.patnum        =   180;
    par.Iter          =   8;
    par.lamada        =   0.56; 
else
    par.patsize       =   9;
    par.patnum        =   200;
    par.Iter          =   8;
    par.lamada        =   0.58; 
end    
par.step      =   5;

% %% Patch and noise Parameters
% if nSig<=10
%     par.patsize       =   6;
%     par.patnum        =   100;
%     par.Iter          =   3;
%     par.lamada        =   0.54;     
% elseif nSig <= 20
%     par.patsize       =   7;
%     par.patnum        =   100;
%     par.Iter          =   4;
%     par.lamada        =   0.56; 
% elseif nSig <= 50
%     par.patsize       =   7;
%     par.patnum        =   120;
%     par.Iter          =   4;
%     par.lamada        =   0.56; 
% else
%     par.patsize       =   9;
%     par.patnum        =   150;
%     par.Iter          =   8;
%     par.lamada        =   0.58; 
% end    
% par.step      =   3;

