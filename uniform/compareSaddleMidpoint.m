function compareSaddleMidpoint()

addpath('helperFunctions/')
rng('default')

% Make sure following values are on higher side when compared to k
% D00
d00 = [9,11];

% D11
d11 = [6,7];

% Make sure following values on lower side when compared to k
% D01
d01 = [-2,2];

% D10
d10 = [1,3];


% isovalue
%k = 4;
k = 4.5;

% Don't mess up order when passing parameters
[w, normalizedW, signProbabilisticSaddle, probS] = saddleDistribution(d00, d11, d01, d10, k);
[m,normalizedM, signProbabilisticMidPoint, probM] = midpointDistribution(d00, d11, d01, d10, k);

% signProbabilisticSaddle
% probS
% signProbabilisticMidPoint
% probM

figure;
subplot(1,2,1);
plotSaddleDistribution(w,normalizedW);
subplot(1,2,2);
plotMidpointDistribution(m,normalizedM);

% get signs corresponding to mean field
m1 = (d00(1,1) + d00(1,2)) /2;
m2 = (d11(1,1) + d11(1,2)) /2;
m3 = (d01(1,1) + d01(1,2)) /2;
m4 = (d10(1,1) + d10(1,2)) /2;
[signSaddleMeanField, signMidpointMeanField] = getMeanFieldSign(m1, m2, m3, m4, k);


