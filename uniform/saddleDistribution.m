function [sdash, normalizedW, signProbabilisticSaddle, probS] = saddleDistribution(d00, d11, d01, d10, k)

[p,pDensity] = getPDensity(d01,d10, k);
pDensity(1,find(isnan(pDensity))) =0;
[q,qDensity] = getQDensity(d00, d11, k);
% Check letter why we get nan in few cases
qDensity(1,find(isnan(qDensity))) =0;

w = conv(pDensity,qDensity);
sdash = linspace(p(1)+q(1), p(end)+q(end), length(w));
normalizedW = w/sum(w);

%plot(sdash, w, 'LineWidth',2.5);

% Find probability: Pr(s'<0)
negativeSaddleProb = sum(normalizedW(find(sdash<0)))

% Most probable sign negative
if(negativeSaddleProb >= 0.5)
    signProbabilisticSaddle = -1; 
    probS = negativeSaddleProb;
% Most probable sign positive
else
    signProbabilisticSaddle = 1; 
    probS = 1-negativeSaddleProb;
end






