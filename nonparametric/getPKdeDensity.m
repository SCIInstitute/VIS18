% Compute probability density of random variable P (Refer to Equation 3 and Section 5.1 in the paper)
% d01, d10: contain uncertain data
% k: isovalue
% plotDensity: yes/no
% monteCarlo: yes/no
% epsilon: tweak in bandwidth

% p: equispaced values representing uncertainty in variable p
% pDensity: density for each value
function [p,pDensity, binWidth] = getPKdeDensity(d01, d10, k, plotDensity, monteCarlo, epsilon)

% Estimate kernel bandwidths for kernel density estimation
bw1 = getBandwidth(d01);
bw2 = getBandwidth(d10);

bw1 = bw1 + epsilon;
bw2 = bw2 + epsilon;

% If you want to test plots for densities
if(strcmp(plotDensity, 'yes'))
    figure;
end

% If you want to compare analytic vs. Monte Carlo
if(strcmp(monteCarlo,'yes'))
    X = getKdeSamples(d01, bw1,10^7);
    Y = getKdeSamples(d10, bw2,10^7);
    
    if(strcmp(plotDensity, 'yes'))        
        % Emperical density kX+kY+XY
        subplot(1,2,1)
        densityEstimate = plotEmpiricalDistribution(k,X,Y,'p');
    end
end

% Compute analytical density for P=kX+kY+XY (Section 5.1 of VIS paper)
[p, pDensity] = getAnalyticalKdeDistribution(d01, bw1, d10, bw2, k);
if(strcmp(plotDensity, 'yes'))
    subplot(1,2,2)
    plotAnalyticalDistribution(p, pDensity, 'p');
end