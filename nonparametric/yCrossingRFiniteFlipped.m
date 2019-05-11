% The expressions for the probabilities were computed through integrations in Equations 11-13 in the paper. 
% We implemented MATLAB symbolic math scripts, simplifiedFiniteDomainPieces.m and simplifiedInfiniteDomainPieces.m, for 
% obtaining the expressions for integrations in Equations 11-13
% k = isovalue, X~[a,b] Y~[c,d], p=kx+ky+xy for some X=x and Y=y, critical: corners of joint support of Y and R (Fig. 6), R~[start,finish]

function probability = yCrossingRFiniteFlipped(k, a, b, c, d, p, critical, start, finish)

% Slopes of four corners starting at the bottom right in counter-clockwist
% direction
c1 = critical(1,1);
c2 = critical(1,2);
c3 = critical(1,3);
c4 = critical(1,4);

probability = 0;

%  R strictly positive
if(start>0)
    
    if (c2 >= 1)
        % p3FiniteA
        probability = -(log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
    elseif (c2 < 1) && (1 <= c3)
         % p4FiniteB
        probability = (log(d + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
    end
    
% R crosses zero
elseif (start <= 0) && (finish >0)
    %c2 < c4
    if (c2 <= c4)
    
       
        if (c2 >= 1)
            % p3FiniteB
            probability = -(log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        elseif (c2 < 1) && (1 <= c4)
            % p4FiniteB
            probability = (log(d + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
        elseif (c4 < 1)
            % p2FiniteA
            probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
        end
            
    %c4 < c2
    elseif (c4 < c2)
    
         if (c4 >= 1)
            % p3FiniteB       
            probability = -(log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        elseif (c4 < 1) && (1 <= c2)
            % p1FiniteA
            probability = -(log(c + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        elseif (c2 < 1)
            % p2FiniteA
            probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
        end
        
    end     
        
% R strictly negative
elseif (finish <= 0)
    
        % p3FiniteB
        if (c4 >= 1)
            probability = -(log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        % p1FiniteA
        elseif (c4 < 1) && (1 <= c1)
            probability = -(log(c + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        end
        
end