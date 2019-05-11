% Img: ensemble of uncertain 2D data
% V (input): the most probable cell topology computed using getMostprobableSignNetwork.m: number in range 1 and 16 (7 and 10 being ambiguous cases of marching squares)
% k: isovalue

% V (output): Topology with resolved ambigous marching squares cases (7/10)
% probArr: Confidence or probability of resolved ambigous topology 

function [V, probArr] =  resolveAmbiguityProbabilisticMidpointDecider(V, Img, k)

% 7 and 10 denote ambiguous configurations
% 7:   isocontour orientation withing a cell -> \\
%10: isocontour orientation withing a cell > //

[x,y]=find((V==7)|(V==10)); 

% # ambigous cells
cellCount = length(x);
temp = V;
probArr = zeros(1, cellCount);

% resolve ambiguity between configurations 7 and 10 probabilistically (probability distribution of cell midpoint) for each cell
for i = 1:cellCount
        posX = x(i);
        posY = y(i);
        
        % Extract uncertain vertex data at cell vertices in counter-clockwise direction starting at top
        d1 = squeeze(Img(posX,posY, :));
        d2 = squeeze(Img(posX+1, posY, :));
        d3 = squeeze(Img(posX+1,posY+1, :));
        d4 =  squeeze(Img(posX,posY+1, :));
      
        % Compute bandwidth of kernel for kernel density estimation of
        % uncertain data at each vertex
        bw1 = getBandwidth(d1);
        bw2 = getBandwidth(d2);
        bw3 = getBandwidth(d3);
        bw4 = getBandwidth(d4);
        epsilon = 0;
        
        %** COMMENT/UNCOMMENT epsilon part below to test effect of
        % kernel bandwidth variations on visualization (Fig. 9 VIS paper)
        % Test effect of bandwidth tweak on result        
        % Set epsilon here and it will take effect everywhere for the
        % probabilistic asymptotic decider code.
        % epsilon =  min([bw1, bw2, bw3, bw4])/2;
        %epsilon = -epsilon;         
        %bw1 = bw1+epsilon;
        %bw2 = bw2+epsilon;
        %bw3 = bw3+epsilon;
        %bw4 = bw4+epsilon;
        
        % Find probability that vertex will attain a negative sign
        p1 = getNegativeSignProbKde(d1, bw1, k);
        p2 = getNegativeSignProbKde(d2, bw2, k);
        p3 = getNegativeSignProbKde(d3, bw3, k);
        p4 = getNegativeSignProbKde(d4, bw4, k);
        
        % If d1 and d3 are negative with probability greater than 0.5
        if (p1 > 0.5) && (p3 > 0.5)
            % without loss of generality assign vertices with negative config to d01 and d10
            d01 = d1;
            d10 = d3;
            d00 = d2;
            d11 = d4;
            
        else
            d01 = d2;
            d10 = d4;
            d00 = d1;
            d11 = d3;
           
        end
        
        %kernel bandwidth modulation
        epsilon = 0;
        % get Sign using probabilistic decider at midpoint
        [m,normalizedM,  signProbabilisticMidPoint, probM] = midpointKdeDistribution(d00, d11, d01, d10, k, epsilon);
        
        probArr(i) = probM;
        
        % Decide topology based on sign of asymtotic decider and assign it
        if(signProbabilisticMidPoint == 1)
           
            % If d1 and d3 are positive
            % Change from mean to most probable sign later
            %if (mean(d1) > k) && (mean(d3) > k)
            if (p1 < 0.5) && (p3 < 0.5)
                temp(posX,posY) = 7;              
            else
                temp(posX, posY) = 10;               
            end
            
        elseif(signProbabilisticMidPoint == -1) 
            % If d1 and d3 are positive
            % Change from mean to most probable sign later
            %if (mean(d1) > k) && (mean(d3) > k)
            if (p1 < 0.5) && (p3 < 0.5)
                temp(posX,posY) = 10;              
            else
                temp(posX, posY) = 7;               
            end
                       
        end
        
end

V = temp;