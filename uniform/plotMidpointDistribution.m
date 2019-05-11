function plotMidpointDistribution(m,normalizedM)

plot(m, normalizedM/10^-4 , 'LineWidth',2.5); hold on;
plot([0,0], [0,1.3], 'LineWidth',2);
set(gca,'FontSize',25)
xlabel("M'", 'FontSize', 30) % x-axis label
ylabel("pdf_M'(m')", 'FontSize', 30) % y-axis label