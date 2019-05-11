function probability = yCrossingRFiniteStandard(k, a, b, c, d, p, critical, start, finish)

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
        probability = (log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));  
    elseif (c2 < 1) && (1 <= c3)
        % p4FiniteA
        probability = (log(d + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
    end
    
% R crosses zero
elseif (start <= 0) && (finish >0)
    %c2 < c4
    if (c2 <= c4)
           
        if (c2 >= 1)
            % p3FiniteA
            probability = (log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));        
        elseif (c2 < 1) && (1 <= c4)
            % p4FiniteA
            probability = (log(d + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));        
        elseif (c4 < 1)
            % p2FiniteB
            probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
        end
            
    %c4 < c2
    elseif (c4 < c2)
       
         if (c4 >= 1)
            % p3FiniteA  
            probability = (log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        elseif (c4 < 1) && (1 <= c2)
            % p1FiniteB
            probability = -(log(c + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
        elseif (c2 < 1)
             % p2FiniteB
             probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
        end
        
    end     
        
% R strictly negative
elseif (finish <= 0)
    
        % p3FiniteA
        if (c4 >= 1)
            probability = (log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        % p1FiniteB
        elseif (c4 < 1) && (1 <= c1)
            probability = -(log(c + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
        end
        
end