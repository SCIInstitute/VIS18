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