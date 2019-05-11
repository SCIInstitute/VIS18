% Distribution of P = kX+kY+XY

addpath('helperFunctions/')
rng('default')

%Uncertainty range
%Good test case 1
% a = 1;
% b = 5;
% c = 10;
% d = 16;
% 
% % isovalue
% k = 6;

% % Good test case 2
% a = 1;
% b = 5;
% c = 1;
% d = 4;
% 
% % isovalue
% k = 2;

% %Good test case 3
% a = 1;
% b = 5;
% c = 1;
% d = 4;
% 
% % isovalue
% k = -2;

% a = -2;
% b = 2;
% c = 1;
% d = 3;
% 
% isovalue
% k = 4;

% a = 9;
% b = 11;
% c = 6;
% d = 7;
% 
% % isovalue
% k = -4;

% a = 2;
% b = 8;
% c = 4;
% d = 6;
% 
% % isovalue
% k = -4;

a = 2;
b = 4;
c = 4;
d = 5;
k = 4;

% a = -8;
% b = -2;
% c = -6;
% d = -4;
% k = 4;


if (c > d) || (a >b)
    disp ('a must be smaller than b and c must be smaller than d');
else
% sum
p = 40;

c1 = k*a+k*c+a*c;
c2 = k*a+k*d+a*d;
c3 = k*b+k*c+b*c;
c4 = k*b+k*d+b*d;

mn = min([c1, c2, c3, c4])
mx = max([c1, c2, c3, c4])

X = uniRand(a,b,10^8);
Y = uniRand(c,d,10^8);

if (p>mx) ||  (p<mn)
    disp('Invalid p value for plotting the R distribution!')
else
    
%     figure
%     % Empirical ratio distribution R = (p-kX)/(k+X)
%     plotEmpiricalRDistribution(k,X,p);
%     
%     % Analytical density R = (p-kX)/(k+X)
%     plotAnalyticalRDistribution(k,a,b,p);
    
end

figure;
% Emperical density kX+kY+XY
subplot(1,2,1)
densityEstimate = plotEmpiricalDistribution(k,X,Y,'p');

% Analytical density P=kX+kY+XY
[P2, densityClosedForm, binWidth] = getAnalyticalDistribution(k,a,b,c,d);
subplot(1,2,2)
plotAnalyticalDistribution(P2, densityClosedForm, 'p');


end    






    


    