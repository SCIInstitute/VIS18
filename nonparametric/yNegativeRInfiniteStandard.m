% The expressions for the probabilities were computed through integrations in Equations 11-13 in the paper. 
% We implemented MATLAB symbolic math scripts, simplifiedFiniteDomainPieces.m and simplifiedInfiniteDomainPieces.m, for 
% obtaining the expressions for integrations in Equations 11-13
% k = isovalue, X~[a,b] Y~[c,d], p=kx+ky+xy for some X=x and Y=y, critical: corners of joint support of Y and R (Fig. 6), R~[start,finish]

function probability = yNegativeRInfiniteStandard(k, a, b, c, d, p, critical, start, finish)

c1 = critical(1,1);
c2 = critical(1,2);
c3 = critical(1,3);
c4 = critical(1,4);

%  R strictly positive
if(start>0)
    % p6InfiniteA
    probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
   
% R crosses zero
elseif (start <= 0) && (finish >0)
    if c3 > 1
       % p6InfiniteA
       probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
    elseif (c3 <= 1) && (1 <= c4)
       % p5InfiniteA
       probability = -(log(c + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
    elseif (c4 < 1)
       probability = 0;
    end
        
% R strictly negative
elseif (finish <= 0)
    if (c4 < c2)
        
        if(c3 > 1)
            % p6InfiniteA
            probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
            
        elseif (c3 <= 1) && (1< c4)     
            % p5InfiniteA
            probability = -(log(c + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
            
        elseif (c4 <= 1) && (1 < c2)
            % p3InfiniteB
             probability = 0;
            
        elseif (c2 <= 1) && (1 <= c1)
            % p2InfiniteB
             probability = (log(d + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
             
        elseif (c1 < 1)
            % p1Infinite
            probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
             
        end
            
    elseif (c2 < c4)
        
        if(c3 > 1)
            % p6InfiniteA
            probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
             
        elseif (c3 <= 1) && (1< c2) 
            % p5InfiniteA
             probability = -(log(c + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
            
        elseif (c2 <= 1) && (1 < c4)
            % p4InfiniteA
            probability = -(log(c + k) - log(d + k) + log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
            
        elseif (c4 <= 1) && (1 <= c1)
             % p2InfiniteB
             probability = (log(d + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
             
        elseif (c1 < 1)
            % p1Infinite
            probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
             
        end        
    end   
end