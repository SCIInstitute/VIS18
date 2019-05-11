function [p,pDensity, binWidth] = getPDensity(d00, d11, k)

a = d00(1,1);
b = d00(1,2);
c = d11(1,1);
d = d11(1,2);


X = uniRand(a,b,10^8);
Y = uniRand(c,d,10^8);

figure;
% Emperical density kX+kY+XY
subplot(1,2,1)
densityEstimate = plotEmpiricalDistribution(k,X,Y,'p');

% Analytical density P=kX+kY+XY
[p, pDensity, binWidth] = getAnalyticalDistribution(k,a,b,c,d);
subplot(1,2,2)
plotAnalyticalDistribution(p, pDensity, 'p');
