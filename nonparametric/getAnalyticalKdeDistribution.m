% d01: Nonparametric density function of variable X
% bw1 : kernel bandwidth for d01
% d10: Nonparametric density function of variable Y
% bw2 : kernel bandwidth for d10
% k : isovalue
% p: equispaced samples of range for uncertain values of random variable P
% pDensity : probability density computed analytically for array p 

function [p, pDensity] = getAnalyticalKdeDistribution(d01, bw1, d10, bw2, k)

%Generate an array of p values
mind01 = min(d01);
maxd01 = max(d01);
mind10 = min(d10);
maxd10 = max(d10);

l1 = mind01 - bw1;
m1 = maxd01 + bw1;
l2 = mind10 -bw2;
m2 =maxd10 + bw2;

% Corners of rectangular boxes in Fig. 6 of VIS paper
critical1 = k*l1+k*l2+l1*l2;
critical2 = k*l1+k*m2+l1*m2;
critical3 = k*m1+k*m2+m1*m2;
critical4 = k*m1+k*l2+m1*l2;

pLow = min([critical1, critical2, critical3, critical4]);
pHigh = max([critical1, critical2, critical3, critical4]);
p = linspace(pLow, pHigh,10000);
binWidth = (pHigh - pLow)/ 10000;

% Initialize the pDensity array with zeros
pDensity = zeros(1,10000);

% Number of kernels per random variable
len1 = length(d01);
len2 = length(d10);
scaleFactor = 1/(len1*len2);

% Loop through each pair of kernels
for i=1:len1
    for j=1:len2
        
        a = d01(1,i) - bw1;
        b =  d01(1,i) + bw1;
        c = d10(1,j) - bw2;
        d =  d10(1,j) + bw2;
        
	% get distribution for a single pair of kernels
        tempDensity = getSinglePairDistribution(k, a, b, c, d, p);
        pDensity = pDensity + scaleFactor*tempDensity;
        
    end
end