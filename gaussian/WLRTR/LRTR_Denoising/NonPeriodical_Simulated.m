function NonP_Stripe   =  NonPeriodical_Simulated(Ori,rate,mean)

% rand('seed',0);
[~, Col] = size(Ori);
Location = randperm(Col,round(rate*Col));
NonP_Stripe=Ori;
NonP_Stripe(:,Location(1:round(rate*Col/2)))=Ori(:,Location(1:round(rate*Col/2))) + mean;
NonP_Stripe(:,Location(round(rate*Col/2)+1:round(rate*Col)))=Ori(:,Location(round(rate*Col/2)+1:round(rate*Col))) - mean;