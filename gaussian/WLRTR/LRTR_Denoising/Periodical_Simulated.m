function P_Stripe   =  Periodical_Simulated(Ori,Perio,rate,mean)

% rand('seed',0);
Location = randperm(Perio,floor(rate*Perio));

[~, Col] = size(Ori);
P_Stripe=Ori;
for i=0:1:floor(Col/Perio)-1   
    P_Stripe(:,Location(1:floor(length(Location)/2)) + i * Perio) = Ori(:,Location(1:floor(length(Location)/2)) + i * Perio) + mean;
    P_Stripe(:,Location(floor(length(Location)/2)+1:length(Location))+ i * Perio) = Ori(:,Location(floor(length(Location)/2)+1:length(Location))+ i * Perio) - mean;
end
