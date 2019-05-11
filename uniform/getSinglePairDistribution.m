function tempDensity = getSinglePairDistribution(k, a, b, c, d, P)

% R density is fixed across all domain ranges
% pdf(r) = (k^2+p)/((k+r)^2*(b-a))
% Get R distribution domain

% Define 4 critical points which define limits of variable kX+kY+XY
% critical1 ~ [(p-ka)/(k+a),c]  = k*a+k*c+a*c
% critical2 ~ [(p-ka)/(k+a),d]  = k*a+k*d+a*d
% critical3 ~ [(p-kb)/(k+b),d]  = k*b+k*d+b*d
% critical4 ~ [(p-kb)/(k+b),c]  = k*b+k*c+b*c

len = length(P);
tempDensity = zeros(1,len);

critical1 = k*a+k*c+a*c;
critical2 = k*a+k*d+a*d;
critical3 = k*b+k*d+b*d;
critical4 = k*b+k*c+b*c;

pLow = min([critical1, critical2, critical3, critical4]);
pHigh = max([critical1, critical2, critical3, critical4]);

% Find indices in array P which fall in the range pLow and pHigh
I = find((P>=pLow) & (P<=pHigh));

%tic
for i = 1:length(I)
    
    idx = I(i);
    p = P(idx);

%     if(abs(p - 0.0583) < 0.001)
%         disp('here');
%     end
    
%     if (i >= 1) || (i <= 5)
%     % Empirical ratio distribution R = (p-kX)/(k+X)
%      plotEmpiricalRDistribution(k,X,p);
%      
%      % Analytical density R = (p-kX)/(k+X)
%      plotAnalyticalRDistribution(k,a,b,p);
%     end 

% if(p > -3)
%     disp('here');
% end
    
    [I1, I2, domainContinuous, order] = getRdensityDomain(k, a, b, p);

    % The critical points are defined from right bottom corner in anti-clockwise fashion based on if order is 'standard' or
    % 'flipped'
    
    % define slopes of the four corners 
    if(strcmp(order,'standard'))
        r1 = (p-k*b)/(k+b);
        r2 = (p-k*a)/(k+a);
        
        c1 = c/r2;
        c2 = d/r2;
        c3 = d/r1;
        c4 = c/r1;
              
    elseif(strcmp(order,'flipped'))      
        r1 = (p-k*a)/(k+a);
        r2 = (p-k*b)/(k+b);
        
        
        c1 = c/r2;
        c2 = d/r2;
        c3 = d/r1;
        c4 = c/r1;        
        
    end 
    
       % Corner slopes in special cases
       
        % strictly positive Y and support rectangle starting on Y axis in
        % first quadrant
        if (r1 == 0) && (c >= 0)
            c3 = inf;
            c4 = inf;
            
        % strictly positive Y and support rectangle ending on Y axis in
        % first quadrant
        elseif (r2 == 0) && (c >= 0)
            c1 = -inf;
            c2 = -inf;
            
        % strictly negative Y and support rectangle ending on Y axis in
        % third quadrant
        elseif(r2 == 0) && (d <= 0)
            c1 = inf;
            c2 = inf;
            
        % strictly negative Y and support rectangle starting on Y axis in
        % third quadrant
        elseif(r1 == 0) && (d <= 0)
            c3 = -inf;
            c4 = -inf;
            
        % Y crossing
        elseif (c < 0) && (d > 0)
            %support rectangle starting on Y axis in first quadrant
            if(r1 == 0)
                c3 = inf;
                c4 = -inf;
            %support rectangle ending on Y axis in third quadrant
            elseif(r2 == 0)
                c1 = inf;
                c2 = -inf;
            end
        end
        
    % Store slopes
     critical = [c1, c2, c3, c4];
     
    % start and finish value for domain of R
    % Important: domain range [start, finish] varies for each p value
    % Y/R = 1 line is always fixed. So support is moving for each p value
    if(domainContinuous == 1)
        start = I1(1,1);
        finish = I1(1,2);
    elseif(domainContinuous == 0)
        start = I1(1,2);
        finish = I2(1,1);
    end
    
    % The order of four critical points can be different depending upon ranges
    % of X and Y and the isovalue k
    
    %tic
    % Analytic density k*X+k*Y+XY
 %% New simplified code
 
 if(domainContinuous == 2)
     disp('Invalid R distribution');
 % Finite domain
 elseif(domainContinuous == 1)
     weight = getProbabilityForFiniteDomain(k, a, b, c, d, p, order, critical);
     % Infinite domain
 elseif(domainContinuous == 0)
     weight = getProbabilityForInfiniteDomain(k, a, b, c, d, p, order, critical);
 end
 
 %!!! Check why this could be happening
 % One reasoning is: it not possible to predict if the rectangle of
 % joint distribution between Y and R will be moving to left or
 % right of the line Y/R = 1 as the P value is changed. This is because p depends on
 % a,b,k,r. I computed assuming that the rectangle always moves from
 % right to left with respect to the line Y/R = 1.
 
 % Above seems a valid reason. The computation of cdf is correct in
 % all cases which is satisfying.
 if (weight<0)
     weight = -weight;
 end
 
 tempDensity(idx) = weight;
          
%% Previous Code    
%     if(domainContinuous == 2)
%         disp('Invalid R distribution');
%     else
%         % Y is strictly positive
%         if c > 0
%             weight = getYstrictlyPositiveDistribution(k, a, b, c, d, p, domainContinuous, order, critical, start, finish);
%             
%          % Y crosses 0
%         elseif (c<=0) && (d>=0)
%             weight = getCrossingYDistribution(k, a, b, c, d, p, domainContinuous, order, critical, start, finish);
%             
%         % Y is strictly negative
%         elseif d < 0
%             weight = getYstrictlyNegativeDistribution(k, a, b, c, d, p, domainContinuous, order, critical, start, finish);          
%         end
%         
%         %!!! Check why this could be happening
%         % One reasoning is: it not possible to predict if the rectangle of
%         % joint distribution between Y and R will be moving to left or
%         % right of the line Y/R = 1 as the P value is changed. This is because p depends on
%         % a,b,k,r. I computed assuming that the rectangle always moves from
%         % right to left with respect to the line Y/R = 1.
%         
%         % Above seems a valid reason. The computation of cdf is correct in
%         % all cases which is satisfying.
%         if (weight<0)
%             weight = -weight;
%         end
%         
%         tempDensity(idx) = weight;
%           
%         end
    
end

%disp('Analytical time:');
%t2 = toc

