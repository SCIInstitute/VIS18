% Img: mean of uncertain data/ certain data
% V: cell topology: number in range 1 and 16 (7 and 10 being ambiguous cases of marching squares)
% k: isovalue
% V: Img with resolved topology (each vertex attains value between 1 and 16)

function V =  resolveAmbiguityAsymptoticDecider(V, Img, k)

% 7 and 10 denote ambiguous configurations
% 7:   isocontour orientation for a single cell -> \\
%10: isocontour orientation for a single cell> //

[x,y]=find((V==7)|(V==10)); 

% # ambigous cells
cellCount = length(x);
temp = V;

% resolve ambiguity between configurations 7 and 10 for each cell
for i = 1:cellCount
        posX = x(i);
        posY = y(i);
        
        % Extract cell data in counter-clockwise direction starting at top
        % left
        d1 = Img(posX,posY);
        d2 = Img(posX+1,posY);
        d3 = Img(posX+1,posY+1);
        d4 = Img(posX,posY+1);
        
        % Only these cases possible since v is either 7 or 10
        if (d1 < k) && (d3 < k)
            % always assign vertices with negative config to d01 and d10
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
        
        % get Sign at the saddle point of a cell
        [signSaddleGTField, signMidpointGTField] = getGroundTruthSign(d00, d01, d10, d11, k);
        
        % Resolve topological ambiguity between 7 and 10 based on the sign of the saddle point
        % (asymptotic decider) 
        if(signSaddleGTField == 1)
            
            if (d1 > k) && (d3 > k)
                temp(posX,posY) = 7;              
            else
                temp(posX, posY) = 10;               
            end
            
        elseif(signSaddleGTField == -1)    
            
            if (d1 > k) && (d3 > k)
                temp(posX,posY) = 10;              
            else
                temp(posX, posY) = 7;               
            end
                       
        end
        
end

V = temp;



