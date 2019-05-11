function plotAnalyticalRDistribution(k, a, b, p)

[I1, I2, domainContinuous, order] = getRdensityDomain(k, a, b, p);

% Invalid domain
if (domainContinuous == 2)
    disp('No ratio density for given value of p and other inputs');
else   
    if(domainContinuous == 1)
        start1 = I1(1,1);
        finish1 = I1(1,2);
        ratio = linspace(start1,finish1,10000);
    elseif(~domainContinuous)
        % -1000 and 1000 represent -Inf and Inf, respectively
        start1 = -1000;
        finish1 = I1(1,2);
        start2 = I2(1,1);
        finish2 = 1000;
        ratio = [linspace(start1,finish1,5000), linspace(start2,finish2,5000)];
    end
    
    rDensity = zeros(1,10000);
    
    for i=1:length(ratio)
        r = ratio(i);
        rDensity(i) = (k^2+p)/((k+r)^2*(b-a));
    end
    subplot(1,2,2)
    plot(ratio,rDensity, 'LineWidth',2.5);
    set(gca,'FontSize',25)
    xlabel('R', 'FontSize', 30) % x-axis label
    ylabel('pdf_R(r)', 'FontSize', 30) % y-axis label
end