% Analytical distribution fo random variable P = kX +  kY + XY (Equation 6)
% or Q = - kX - kY + XY 
function plotAnalyticalDistribution(var, density, varName)

plot(var,density,'LineWidth',2.5);
set(gca,'FontSize',25)
if (strcmp(varName,'p'))
    xlabel('P',  'FontSize', 30) % x-axis label
    ylabel('pdf_P(p)',  'FontSize', 30) % y-axis label
elseif (strcmp(varName,'q'))
    xlabel('Q',  'FontSize', 30) % x-axis label
    ylabel('pdf_Q(q)',  'FontSize', 30) % y-axis label
else
    disp('Invalid variable name');
end