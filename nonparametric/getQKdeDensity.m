% Compute probability density of random variable Q (Refer to Equation 3, Section 5.1, and Section 5.3 in the paper)
% d01, d10: contain uncertain data
% k: isovalue
% plotDensity: yes/no
% monteCarlo: yes/no
% epsilon: tweak in bandwidth

% q: equispaced values representing uncertainty in variable p
% qDensity: density for each value
function [q, qDensity, binWidth] = getQKdeDensity(d00,d11, k, plotDensity, monteCarlo, epsilon)

% Estimate bandwidth
bw1 = getBandwidth(d00);
bw2 = getBandwidth(d11);

bw1 = bw1 + epsilon;
bw2 = bw2 + epsilon;

% If you want to test plots for densities
if(strcmp(plotDensity, 'yes'))
    figure;
end

% If you want to compare analytic vs. Monte Carlo
if (strcmp(monteCarlo,'yes'))
    X = getKdeSamples(d00, bw1,10^7);
    Y = getKdeSamples(d11, bw2,10^7);
    
    if (strcmp(plotDensity,'yes'))        
        % Emperical density kX+kY+XY
        % remember to pass negative of isovalue
        subplot(1,2,1)
        densityEstimate = plotEmpiricalDistribution(-k,X,Y,'q');
    end
end

% Analytical density Q=-kX-kY+XY (Section 5.1 and Section 5.3 of VIS paper)
% remember to pass the negative of isovalue k
[q, qDensity] = getAnalyticalKdeDistribution(d00, bw1, d11, bw2, -k);

if (strcmp(plotDensity,'yes'))
    subplot(1,2,2)
    plotAnalyticalDistribution(q, qDensity, 'q');
end