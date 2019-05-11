% Empirical distribution fo random variable P = kX +  kY + XY (Equation 6)
function densityEstimate = plotEmpiricalDistribution(k, X, Y, varname)
%tic
h = histogram(k*X + k*Y + X.*Y,10000,'Normalization','pdf'); hold on;
%disp('Empirical time:')
%t1 = toc
densityEstimate = h.Values;
set(gca,'FontSize',25)

if(strcmp(varname,'p'))
    xlabel('P',  'FontSize', 30) % x-axis label
    ylabel('pdf_P(p)',  'FontSize', 30) % y-axis label
elseif(strcmp(varname,'q'))
    xlabel('Q',  'FontSize', 30) % x-axis label
    ylabel('pdf_Q(q)',  'FontSize', 30) % y-axis label
else
    disp('Invalid variable name');
end

%title('kX+kY+XY')
