function  [X] =  TWNNM( Y, C, NSig)
PatNum      =  size(Y,2);
[SigmaY, V, ~, ~] = hosvd(Y);
TempC       =  C*sqrt(PatNum)*2*NSig^2;
temp        =  (SigmaY-eps).^2 - TempC./abs(SigmaY);
% temp        =  (SigmaY).^2- 3*NSig^2;
ind         =  find (temp>0);
SigmaX      =  zeros(size(SigmaY));
SigmaX(ind) =  max(abs(SigmaY(ind))+sqrt(temp(ind)),0)/2.*sign(SigmaY(ind));
X           =  tprod(SigmaX, V);
return;

