% The density function has turned to be same across all domains
% pdf = (k^2 + p)/((k+r)^2*(b-a));

% k: isovalue
% X in [a,b] .. a<b
% p is value of kX+kY+XY

function [I1, I2, domainContinuous, order] = getRdensityDomain(k, a, b, p)

end1R1 = p-k*a;
end1R2 = k+a;
end2R1 = p-k*b;
end2R2 = k+b;

% If (p-kb)/(k+b) <  (p-ka)/(k+a), the order defined is standard
% If (p-ka)/(k+a) <  (p-kb)/(k+b), the order defined is flipped

end1 = end1R1/end1R2;
end2 = end2R1/end2R2;

I1 = nan;
I2 = nan;
I1Assigned = 0;
I2Assigned = 0;

if(a > b)
    disp('Invalid input! a needs to be smaller than b');
else
    %  k+X is strictly positive (non-breaking domain)
    if end1R2 >=0 && end2R2 > 0
        if end1 <= end2
            I1 = [end1,end2];
            I1Assigned = 1;
            order = 'flipped';
        else
            I1 = [end2,end1];
            I1Assigned = 1;
            order = 'standard';
        end
    
    
    % k+X is strictly negative (non-breaking domain)
    elseif end1R2<0 && end2R2 <= 0
        if end1 <= end2
            I1 = [end1,end2];
            I1Assigned = 1;
            order = 'flipped';
        else
            I1 = [end2,end1];
            I1Assigned = 1;
            order = 'standard';
        end
    
    
    % k+X crosses zero (breaking domain)
    elseif end1R2 < 0 &&  end2R2 > 0
        if end1R1 >=0 && end2R1 >= 0
            % end1(quadrant 4) has to be smaller than the end2(quadrant 1)
            I1 = [-inf,end1]; 
            I2 = [end2,inf];
            I1Assigned = 1;
            I2Assigned = 1;
            order = 'flipped';
        elseif end1R1 >=0 && end2R1 <= 0
            % Intersection of line of cdf with vertical axis is at
            % coordinate p+k^2
            if(p + k^2 >= 0)
                % Only this case possible
                I1 = [-inf,end1];
                I2 = [end2,inf]; 
                I1Assigned = 1;
                I2Assigned = 1;
                order = 'flipped';
            elseif (p + k^2 < 0)
                % Only this case possible
                I1 = [-inf,end2];
                I2 = [end1,inf];
                I1Assigned = 1;
                I2Assigned = 1;
                order = 'standard';
            end            
        elseif end1R1 <=0 && end2R1 >=0
             % Intersection of line of cdf with vertical axis is at
            % coordinate p+k^2
            if(p + k^2 >= 0)
                % Only this case possible
                I1 = [-inf,end1];
                I2 = [end2,inf];
                I1Assigned = 1;
                I2Assigned = 1;
                order = 'flipped';
            elseif (p + k^2 < 0)
                % Only this case possible
                I1 = [-inf,end2];
                I2 = [end1,inf];
                I1Assigned = 1;
                I2Assigned = 1;
                order = 'standard';
            end        
        elseif end1R1 <=0 && end2R1 <=0
            % end1(quadrant 3) has to be greater than the end2(quadrant 2)
            I1 = [-inf,end2];
            I2 = [end1,inf];
            I1Assigned = 1;
            I2Assigned = 1;
            order = 'standard';
        end
    end
end

% Non-breaking domain
if(I1Assigned == 1 && I2Assigned == 0)
    domainContinuous = 1;
% Breaking domain
elseif(I1Assigned == 1 && I2Assigned == 1)
    domainContinuous = 0;
% Invalid domain
else
    domainContinuous = 2;
end
    
end