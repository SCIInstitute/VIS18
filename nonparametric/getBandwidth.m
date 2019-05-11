% Kernel bandwidth estimation (uniform kernel) for nonparametric densities using Silverman's rule of thumb
function bw = getBandwidth(data)

% sample variation
sigma = min(1/1.34*iqr(data), std(data));
% second moment of kernel k2  = 1/3
% int K(t)^2 = 1/2
% k2 ^-2/5 * (int K(t)^2)^1/5 = (9/2)^(1/5)

coeff1 = (9/2)^1/5;
coeff2 = ((3/8)*pi^(-1/2)*sigma^-5)^(-1/5);
coeff3 = length(data)^(-1/5);
bw = coeff1*coeff2*coeff3;

bw = bw/2;



