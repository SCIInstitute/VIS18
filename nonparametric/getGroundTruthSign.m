% d00, d01, d10, d11: Values at the cell vertices
% k : isovalue
% Make sure that d00 and d11 are greater than d01 and d10 by structure for
% computing saddle
function [signSaddleGTField, signMidpointGTField] = getGroundTruthSign(d00, d01, d10, d11, k)

saddleGTValue =  (d00*d11 + d01*d10)/ (d00 - d01 - d10 + d11);

midpointGTValue = (d00 + d01 + d10 + d11)/4;

% Saddle point sign
if(saddleGTValue < k)
    signSaddleGTField = -1;
else
     signSaddleGTField = 1;
end

% Midpoint sign
if(midpointGTValue < k)
    signMidpointGTField = -1;
else
     signMidpointGTField = 1;
end
