function [q, qDensity, binWidth] = getQDensity(d01,d10, k)

a = d01(1,1);
b = d01(1,2);
c = d10(1,1);
d = d10(1,2);


X = uniRand(a,b,10^8);
Y = uniRand(c,d,10^8);

figure;
% Emperical density kX+kY+XY
subplot(1,2,1)
% remember to pass negative of isovalue
densityEstimate = plotEmpiricalDistribution(-k,X,Y,'q');

% Analytical density P=kX+kY+XY
% remember to pass negative of isovalue
[q, qDensity, binWidth] = getAnalyticalDistribution(-k,a,b,c,d);
subplot(1,2,2)
plotAnalyticalDistribution(q, qDensity, 'q');