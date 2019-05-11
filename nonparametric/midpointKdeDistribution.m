% % d00, d11, d01, d10: Uncertain data values at the cell corners
% k : isovalue
% epsilon: Test effect of change in bandwidth estimation on result

% normalizedM : Probability distribution at the cell midpoint
% signProbabilisticMidPoint: The most probable midpoint sign
% probM: The probability of the most probable midpoint sign
% negativeProb: Probability of cell midpoint being negative
function [m,normalizedM,  signProbabilisticMidPoint, probM, negativeProb] = midpointKdeDistribution(d00, d11, d01, d10, k, epsilon)

% Estimate bandwidth for base kernel of nonparametric distribution
bw1 = getBandwidth(d00);
bw2 = getBandwidth(d11);
bw3 = getBandwidth(d01);
bw4 = getBandwidth(d10);

bw1 = bw1 + epsilon;
bw2 = bw2 + epsilon;
bw3 = bw3 + epsilon;
bw4 = bw4 + epsilon;

% Discrete functions approximating Kernel density functions at four vertices of a cell
pts = linspace(min(d00)-bw1, max(d00) + bw1, 5000);
X1 = ksdensity(d00, pts, 'Bandwidth', bw1,'Kernel', 'box');

pts = linspace(min(d11)-bw2, max(d11) + bw2, 5000);
Y1 = ksdensity(d11, pts, 'Bandwidth', bw2,'Kernel', 'box');

pts = linspace(min(d01)-bw3, max(d01) + bw3, 5000);
X2 = ksdensity(d01, pts, 'Bandwidth', bw3,'Kernel', 'box');

pts = linspace(min(d10)-bw4, max(d10) + bw4, 5000);
Y2 = ksdensity(d10, pts, 'Bandwidth', bw4,'Kernel', 'box');

% Discrete convolution of nonparametric density functions at the four corners of a cell
P = conv(X1, Y1);
Q = conv(X2,Y2);
mDensity = conv(P,Q);
mn = min(d00) - bw1 + min(d11) - bw2 + min(d01) - bw3 + min(d10) - bw4 - 4*k;
mx = max(d00) + bw1 + max(d11) + bw2 + max(d01) + bw3 + max(d10) + bw4 - 4*k;
% discrete convolution of kernel density functions at the cell vertices
m = linspace(mn,mx,length(mDensity));
% probability distribution at the cell midpoint
normalizedM = mDensity/sum(mDensity);
%plot(m, mDensity, 'LineWidth',2.5);

% Find probability: Pr(m'<0): Equation (7) in paper
ind = find(m<0);
if isempty(ind)
    negativeMidpoinProb = 0
else
    negativeMidpoinProb = sum(normalizedM(ind))
end
negativeProb = negativeMidpoinProb;

if isnan(negativeMidpoinProb)
  disp('here');
end
% if the most probable sign at the cell midpoint is negative
if(negativeMidpoinProb >= 0.5)
    signProbabilisticMidPoint = -1; 
    probM = negativeMidpoinProb;
% if the most probable sign at the cell midpoint is positive
else
    signProbabilisticMidPoint = 1; 
    probM = 1-negativeMidpoinProb;
end