function plotEmpiricalRDistribution(k, X, p)

%title('Distribution of R')
R = (p-k*X)./(k+X);
subplot(1,2,1)
histogram(R,10000,'Normalization','pdf');
set(gca,'FontSize',25)
xlabel('R',  'FontSize', 30) % x-axis label
ylabel('pdf_R(r)',  'FontSize', 30) % y-axis label
