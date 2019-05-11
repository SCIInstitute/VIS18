function [m,normalizedM,  signProbabilisticMidPoint, probM] = midpointDistribution(d00, d11, d01, d10, k)

X1 = ones(1,5000)*1/(d00(1,2) - d00(1,1));
Y1 = ones(1,5000)*1/(d11(1,2) - d11(1,1));
X2 = ones(1,5000)*1/(d10(1,2) - d10(1,1));
Y2 = ones(1,5000)*1/(d01(1,2) - d01(1,1));

P = conv(X1, Y1);
Q = conv(X2,Y2);
mDensity = conv(P,Q);
mn = d00(1,1) + d11(1,1) + d10(1,1) + d01(1,1) - 4*k;
mx = d00(1,2) + d11(1,2) + d10(1,2) + d01(1,2) - 4*k;
m = linspace(mn,mx,length(mDensity));
normalizedM = mDensity/sum(mDensity);
%plot(m, mDensity, 'LineWidth',2.5);

% Find probability: Pr(m'<0)
negativeMidpoinProb = sum(normalizedM(find(m<0)))

% Most probable sign negative
if(negativeMidpoinProb >= 0.5)
    signProbabilisticMidPoint = -1; 
    probM = negativeMidpoinProb;
% Most probable sign positive
else
    signProbabilisticMidPoint = 1; 
    probM = 1-negativeMidpoinProb;
end