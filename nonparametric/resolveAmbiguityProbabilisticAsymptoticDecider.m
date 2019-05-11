% Img: ensemble of uncertain 2D data
% V (input): the most probable cell topology computed using getMostprobableSignNetwork.m: number in range 1 and 16 (7 and 10 being ambiguous cases of marching squares)
% k: isovalue

% V (output): Topology with resolved ambigous marching squares cases (7/10)
% probArr: Confidence in resolved ambigous topology 

function [V, probArr] =  resolveAmbiguityProbabilisticAsymptoticDecider(V, Img, k)

% 7 and 10 denote ambiguous configurations
% 7:   face orientation -> \\
%10: face orientation > //

% Find all cells with ambiguous marching squares configurations (7 or 10)
[x,y]=find((V==7)|(V==10)); 

% # ambigous cells
cellCount = length(x);
probArr = zeros(cellCount);
temp = V;

% resolve ambiguity between configurations 7 and 10 probabilistically (probability distribution of saddle point for a cell) for each cell
for i = 1:cellCount
        posX = x(i);
        posY = y(i);
        
        % Extract cell data in counter-clockwise direction starting at top
        % left
        d1 = squeeze(Img(posX,posY, :));
        d2 = squeeze(Img(posX+1, posY, :));
        d3 = squeeze(Img(posX+1,posY+1, :));
        d4 =  squeeze(Img(posX,posY+1, :));
        
        % Only these cases possible since v is either 7 or 10
        
        % Compute most probable signs for the following
        
        bw1 = getBandwidth(d1);
        bw2 = getBandwidth(d2);
        bw3 = getBandwidth(d3);
        bw4 = getBandwidth(d4);
        epsilon = 0;
        
        %** COMMENT epsilon part immediately after testing effect on
        %kernel bandwidth on visualization
        % Test effect of bandwidth tweak on result        
        % Set epsilon here and it will take effect everywhere for the
        % probabilistic asymptotic decider code.
%         epsilon =  min([bw1, bw2, bw3, bw4])/2;
%         epsilon = -epsilon;
%         
%         bw1 = bw1+epsilon;
%         bw2 = bw2+epsilon;
%         bw3 = bw3+epsilon;
%         bw4 = bw4+epsilon;
%         
        p1 = getNegativeSignProbKde(d1, bw1, k);
        p2 = getNegativeSignProbKde(d2, bw2, k);
        p3 = getNegativeSignProbKde(d3, bw3, k);
        p4 = getNegativeSignProbKde(d4, bw4, k);
        
        % The signd of p1,p3 and p2,p4 should be opposite or 
        % the cell does not ambiguous configuration
        
        % If d1 and d3 are -ve with higher probability
        %if (mean(d1) < k) && (mean(d3) < k)
        if (p1 > 0.5) && (p3 > 0.5)
            % refer fig 1 in paper
            % always assign vertices with negative config to d01 and d10
            % saddle point function procesees row array, so take transpose
            % pf column vectors
            d01 = d1';
            d10 = d3';
            d00 = d2';
            d11 = d4';
            
        else
            d01 = d2';
            d10 = d4';
            d00 = d1';
            d11 = d3';       
        end
        
        % get Sign using probabilistic decider at saddle point
        % If you want to plot densities or try Monte-Carlo, set 'yes' for the following
        % You may need to make a few adjustments in the following functions being called to
	% create visualizations using the 'yes' option
        plotDensity = 'no';
        monteCarlo = 'no';

        % Find probability distribution of the uncertain saddle values (Our vis 18 contribution!!)
        [sdash, normalizedW, signProbabilisticSaddle, probS] = saddleKdeDistribution(d00, d11, d01, d10, k, plotDensity, monteCarlo, epsilon);
        probArr(i) = probS;
         
        % Decide topology based on sign of asymtotic decider and assign it
        if(signProbabilisticSaddle == 1)
           
            % If d1 and d3 are positive
            % Change from mean to most probable sign later
            %if (mean(d1) > k) && (mean(d3) > k)
            if (p1 < 0.5) && (p3 < 0.5)
                temp(posX,posY) = 7;              
            else
                temp(posX, posY) = 10;               
            end
            
        elseif(signProbabilisticSaddle == -1)    
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