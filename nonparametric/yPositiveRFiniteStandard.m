% The expressions for the probabilities were computed through integrations in Equations 11-13 in the paper. 
% We implemented MATLAB symbolic math scripts, simplifiedFiniteDomainPieces.m and simplifiedInfiniteDomainPieces.m, for 
% obtaining the expressions for integrations in Equations 11-13
% k = isovalue, X~[a,b] Y~[c,d], p=kx+ky+xy for some X=x and Y=y, critical: corners of joint support of Y and R (Fig. 6), R~[start,finish]

function probability = yPositiveRFiniteStandard(k, a, b, c, d, p, critical, start, finish)

c1 = critical(1,1);
c2 = critical(1,2);
c3 = critical(1,3);
c4 = critical(1,4);

% R strictly positive
% R can vary between [(p-kb)/(k+b),(p-ka)/(k+a)] OR  [(p-ka)/(k+a),(p-kb)/(k+b)]
% We need to know the order since the CDF, abd hence, pdf depends upon
% the order

probability = 0;

%  R strictly positive
if(start>0)
    % c1 < c2 < c4 < c3
    if(c2 <= c4)
        if (c1 > 1)
            probability = 0;
        elseif (c1 <= 1) && (1 < c2)
            % p1FiniteB
            probability = -(log(c + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
        elseif  (c2 <= 1) && (1 < c4)
            % p2FiniteB
            probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));            
        elseif (c4 <= 1) && (1 <= c3)
            % p4FiniteA
            probability = (log(d + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));          
        elseif (c3 < 1)
            probability = 0;
        end
        
    % c1 < c4 < c2 < c3
    elseif(c4 < c2)
        if (c1 > 1)
            probability = 0;
        elseif (c1 <= 1) && (1 < c4)
            % p1FiniteB
            probability = -(log(c + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
        elseif  (c4 <= 1) && (1 < c2)
            % p3FiniteA
            probability = (log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        elseif (c2 <= 1) && (1 <= c3)
            % p4FiniteA
            probability = (log(d + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        elseif (c3 < 1)
            probability = 0;
        end
    end
    
 % R crosses zero
elseif (start <= 0) && (finish >0)
    if (c1 > 1)
        probability = 0;
    elseif (c1 <= 1) && (1 <= c2)
        % p1FiniteB
        probability = -(log(c + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
    elseif (c2 < 1)
        % p2FiniteB
        probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
    end
        
% R strictly negative
elseif (finish <= 0)
    % In all cases
    probability = 0;
end