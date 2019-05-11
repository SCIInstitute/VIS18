% Compute probability of vertex being negative at a single grid vertex for a given isovalue and nonparametric distribution
% members: Kernel centers
% bw: kernel bandwidth
% k: isovalue
% negativeProb: Probability of vertex to attain a negative sign
function negativeProb = getNegativeSignProbKde(members, bw, k)

negativeProb = 0;

mn = min(members);
mx = max(members);
numKernels = length(members);

if(k <= mn - bw)
    negativeProb = 0;    
elseif (k >= mx+bw)
    negativeProb = 1;    
else
    for i =1:numKernels
        scale = 1/numKernels;
        if (k <= members(i) - bw)    
             negativeProb= negativeProb + 0;
        elseif(k >= members(i)+bw)
             negativeProb= negativeProb + scale;
        else
             temp = (k - (members(i) - bw))/(2*bw);
             negativeProb = negativeProb + scale*temp; 
        end
        
    end
end


