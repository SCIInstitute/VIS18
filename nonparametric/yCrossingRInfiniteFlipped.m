% The expressions for the probabilities were computed through integrations in Equations 11-13 in the paper. 
% We implemented MATLAB symbolic math scripts, simplifiedFiniteDomainPieces.m and simplifiedInfiniteDomainPieces.m, for 
% obtaining the expressions for integrations in Equations 11-13
% k = isovalue, X~[a,b] Y~[c,d], p=kx+ky+xy for some X=x and Y=y, critical: corners of joint support of Y and R (Fig. 6), R~[start,finish]

function probability = yCrossingRInfiniteFlipped(k, a, b, c, d, p, critical, start, finish)

% Slopes of four corners starting at the bottom right in counter-clockwist
% direction
c1 = critical(1,1);
c2 = critical(1,2);
c3 = critical(1,3);
c4 = critical(1,4);

%  R strictly positive
if(start>0)
        
    if (c2 > 1)
        % p4InfiniteB
        probability = -(log(c + k) - log(d + k) - log((k^2 + p)/(a + k)) + log((k^2 + p)/(b + k)))/((a - b)*(c - d));
    elseif (c2<= 1) && (1<=c3)
        % p5InfiniteB
        probability = -(log(c + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
    elseif (c3 < 1)
        % p6InfiniteB
        probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
    end
    
% R crosses zero
elseif (start <= 0) && (finish >0)
    
    if(c2 <= c4)
                
        if (c2 > 1)
            % Changed in revised code
            % commented
            % probability = -(log(c + k) - log(d + k))/((a - b)*(c - d))
            % p4InfiniteB  
            probability = -(log(c + k) - log(d + k) - log((k^2 + p)/(a + k)) + log((k^2 + p)/(b + k)))/((a - b)*(c - d));                 
        elseif (c2 <= 1) && (1 <= c4)
            % Changed in revised code
            % commented
            % probability = -(log(c + k) - log((k^2 + p)/(b + k)))/((a -b)*(c - d));
            % p5InfiniteB
            probability = -(log(c + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
        elseif (c4 <1)
            probability = 0;
        end
        
    elseif (c4 < c2)
           
         if (c4 > 1)
            % Changed in revised code
            % commented
            % probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
            % p4InfiniteB  
            probability = -(log(c + k) - log(d + k) - log((k^2 + p)/(a + k)) + log((k^2 + p)/(b + k)))/((a - b)*(c - d));        
        elseif (c4 <= 1) && (1 <= c2)
            % p2InfiniteA
            probability = (log(d + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));    
        elseif (c2 <1)
            probability = 0;
        end
        
    end
    
% R strictly negative
elseif (finish <= 0)
    if (c4 > 1)
         % p4InfiniteB
         probability = -(log(c + k) - log(d + k) - log((k^2 + p)/(a + k)) + log((k^2 + p)/(b + k)))/((a - b)*(c - d));
    elseif (c4<= 1) && (1<=c1)
         % p2InfiniteA
         probability = (log(d + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
    elseif (c1 < 1)
          % p1Infinite
         probability =  -(log(c + k) - log(d + k))/((a - b)*(c - d));
    end
    
end