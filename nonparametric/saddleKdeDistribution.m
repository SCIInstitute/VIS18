% d00, d11, d01, d10: Uncertain data values at the cell corners
% k : isovalue
% plotDensity, monteCarlo: flags ('yes'/'no') to plot densities or use Monte Carlo
% epsilon : Test the effect of tweaks in bandwidth estimated using the Silverman's rule of thumb.

% sdash:  P + Q, equation 6 in VIS paper
% normalizedW : Probability distribution of variable sdash
% signProbabilisticSaddle: The most probable saddle point sign
% probM: The probability of the most probable saddle point sign
% negativeProb: Probability of cell saddle point being negative

function [sdash, normalizedW, signProbabilisticSaddle, probS, negativeProb] = saddleKdeDistribution(d00, d11, d01, d10, k, plotDensity, monteCarlo, epsilon)

% The density of the random variable P (See Equation 6 and Section 5.1 in the paper)
[p,pDensity] = getPKdeDensity(d01,d10, k, plotDensity, monteCarlo, epsilon);
pDensity(1,find(isnan(pDensity))) =0;
pDensity(imag(pDensity) ~= 0) = 0;

% The density of the random variable Q (See Equation 6 and Section 5.3 in the paper)
[q,qDensity] = getQKdeDensity(d00, d11, k, plotDensity, monteCarlo, epsilon);
% Check letter why we get nan in few cases
qDensity(1,find(isnan(qDensity))) =0;
qDensity(imag(qDensity) ~= 0) = 0;

% Convolution of probability densities of random variables P and Q (Section 5.3)
w = conv(pDensity,qDensity);
sdash = linspace(p(1)+q(1), p(end)+q(end), length(w));
normalizedW = w/sum(w);
%plot(sdash, w, 'LineWidth',2.5);

% Find probability: Pr(s'<0) (Equation 6 in paper)
negativeSaddleProb = sum(normalizedW(find(sdash<0)))
negativeProb = negativeSaddleProb;

% if  the most probable sign is negative
if(negativeSaddleProb >= 0.5)
    signProbabilisticSaddle = -1; 
    probS = negativeSaddleProb;
% if the most probable sign is positive
else
    signProbabilisticSaddle = 1; 
    probS = 1-negativeSaddleProb;
end

