function probability = yPositiveRFiniteFlipped(k, a, b, c, d, p, critical, start, finish)

c1 = critical(1,1);
c2 = critical(1,2);
c3 = critical(1,3);
c4 = critical(1,4);

%  R strictly positive
if(start>0)
    % c1 < c2 < c4 < c3
    if(c2 <= c4)
        if (c1 > 1)
            probability = 0;
        elseif (c1 <= 1) && (1 < c2)
            % p1FiniteA
            probability = -(log(c + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        elseif  (c2 <= 1) && (1 < c4)
            %  p2FiniteA
            probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
        elseif (c4 <= 1) && (1 <= c3)
            % p4FiniteB
            probability = (log(d + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
        elseif (c3 < 1)
            probability = 0;
        end
        % c1 < c4 < c2 < c3
    elseif(c4 < c2)
        if (c1 > 1)
            probability = 0;
        elseif (c1 <= 1) && (1 < c4)
            % p1FiniteA
            probability = -(log(c + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        elseif  (c4 <= 1) && (1 < c2)
            % p3FiniteB
            probability = -(log((k^2 + p)/(a + k)) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
        elseif (c2 <= 1) && (1 <= c3)
            % p4FiniteB
            probability = (log(d + k) - log((k^2 + p)/(a + k)))/((a - b)*(c - d));
        elseif (c3 < 1)
            probability = 0;
        end
    end
    
% R crosses zero
elseif (start <= 0) && (finish >0)

    if (c1 > 1)
        probability = 0;
    elseif (c1 <= 1) && (1 <= c2)
        % p1FiniteA
        probability = -(log(c + k) - log((k^2 + p)/(b + k)))/((a - b)*(c - d));
    elseif (c2 < 1)
        % p2FiniteA
        probability = -(log(c + k) - log(d + k))/((a - b)*(c - d));
    end
    
% R strictly negative
elseif (finish <= 0)
    % In all cases
    probability = 0;
end