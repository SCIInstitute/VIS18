
% Assume kernel density estimation for deriving saddle point distribution
% and midpoint distribution

% k: Isovalue
% plotDensity: 'yes'/'no'
%monteCarlo: 'yes'/'no' (Do monte carlo sampling or not for comparing results with analytical)
function [signProbabilisticSaddle, signProbabilisticMidPoint, signSaddleMeanField, signMidpointMeanField, signSaddleGT, signMidpointGT, probS, probM] = compareSaddleMidpoint(k, plotDensity, monteCarlo)

rng('default')

% % Make sure following values are on higher side when compared to k
% % D00
% d00 = [9,11];
% 
% % D11
% d11 = [6,7];
% 
% % Make sure following values on lower side when compared to k
% % D01
% d01 = [-2,2];
% 
% % D10
% d10 = [1,3];

% % Make sure following values are on higher side when compared to k
d00 = [10, 10.2, 10.3 10.3, 11];
d11 = [6, 6.1, 6.2, 6.3, 6.9];

% % Make sure following values on lower side when compared to k
d01 = [-1,-1.1,-1.3, -0.8, -1.6];
d10 = [1, 1.3, 1.2, 1.3, 2.8];

noOutlierd00 = [10, 10.2, 10.1,10.3];
noOutlierd11 = [6, 6.1, 6.2, 6];
noOutlierd01 = [-1,-1.1,-1, -1];
noOutlierd10 =  [1, 1.3, 1.2, 1.3];

% isovalue
%k = 4;

% Plot densities or not
%plotDensity = 'no';
% perform monteCarlo sampling or not
%monteCarlo = 'no';

% variation in bandwidth
epsilon = 0;

% Don't mess up order when passing parameters
[w, normalizedW, signProbabilisticSaddle, probS] = saddleKdeDistribution(d00, d11, d01, d10, k, plotDensity, monteCarlo, epsilon);

[m,normalizedM, signProbabilisticMidPoint, probM] = midpointKdeDistribution(d00, d11, d01, d10, k, epsilon);

% signProbabilisticSaddle
% probS
% signProbabilisticMidPoint
% probM

%  Plotting Routine
if(strcmp(plotDensity,'yes'))
    figure;
    subplot(1,2,1);
    plotSaddleDistribution(w,normalizedW);
    subplot(1,2,2);
    plotMidpointDistribution(m,normalizedM);
end

% get signs corresponding to mean field
m1 = mean(d00);
m2 = mean(d11);
m3 = mean(d01);
m4 =mean(d10);
[signSaddleMeanField, signMidpointMeanField] = getMeanFieldSign(m1, m2, m3, m4, k);

% % get signs corresponding to mean field for no outlier scenario
% m1 = mean(noOutlierd00);
% m2 = mean(noOutlierd11);
% m3 = mean(noOutlierd01);
% m4 =mean(noOutlierd10);
% [signSaddleMeanField, signMidpointMeanField] = getMeanFieldSign(m1, m2, m3, m4, k);
g1 = 10;
g2 = 6.1;
g3 = -1;
g4 = 1.2;
[signSaddleGT, signMidpointGT] = getGroundTruthSign(g1, g2, g3, g4, k);

