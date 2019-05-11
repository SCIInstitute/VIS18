% -------------------------------------------
%   Title: The Probabilistic Asymptotic Decider for Topological Ambiguity Resolution 
%	  in Level-Set Extraction for Uncertain 2D Data.
%   Authors: Tushar Athawale and Chris R. Johnson	
%   Date: 03/01/2019
% ------------------------------------------

% I: 3D representing ensemble of 2D uncertain members (possible deciderFrameworks: 'probabilisticAsymptotic', 'probabilisticMidpoint', 'meanAsymptotic', 'mean')
% I: 2D certain data (possible deciderFrameworks: 'asymptotic', 'midpoint')
% isovalue: Isovalue

function [Lines,Vertices,Objects, time, topology]=myIsocontour(I,isovalue, deciderFramework)

% Check Inputs
if(nargin==0), error('isocontour:input','no input image defined'); end

% Predict most probable isocontour topology
[Vertices,Lines, markAmbiguousCells, mostProbableImage, time, topology]=LookupDB(I,isovalue, deciderFramework);

% Sort the Line Pieces into objects
if(nargout==4||nargout==0||nargout==5)
    Objects=SortLines2Objects(Lines);
end

% Show image, if no output asked
if(nargout==0) 
 
% Render confidence information for predicted isocontour topology if input image I is ensemble of 2D uncertain data
if(strcmp(deciderFramework, 'probabilisticAsymptotic') || strcmp(deciderFramework, 'probabilisticMidpoint'))
    maxProbability = max(markAmbiguousCells(:));
    markAmbiguousCells(markAmbiguousCells == 0)= NaN;
    % Make pixels with NAN transparent (if any)
    imagesc(markAmbiguousCells, 'AlphaData',~isnan(markAmbiguousCells)), hold on;
    % Set background color
    set(gca,'color',0.85*[1 1 1]);
    
    % Colormap for confidence representation
    r1 = linspace(244,253,10);
    r2 = linspace(253,254,10);
    r3 = linspace(254,224,10);
    r4 = linspace(224,171,10);
    r5 = linspace(171,116,10);
   
    R = [r1, r2, r3, r4, r5];
    R = R/ 255;
    
    g1 = linspace(109,174,10);
    g2 = linspace(174,224,10);
    g3 = linspace(224,243,10);
    g4 = linspace(243,217,10);
    g5 = linspace(217,173,10);
    
    G = [g1, g2, g3, g4, g5];
    G = G/ 255;
    
    b1 = linspace(67,97,10);
    b2 = linspace(97,144,10);
    b3 = linspace(144,248,10);
    b4 = linspace(248,233,10);
    b5 = linspace(233,209,10);
    
    B = [b1, b2, b3, b4, b5];
    B = B/ 255;
   
% Colormap for the vis paper
%     r1 = linspace(165,215,10);
%     r2 = linspace(215,244,10);
%     r3 = linspace(244,253,10);
%     r4 = linspace(253,254,10);
%     r5 = linspace(254,224,10);
%     r6 = linspace(224,171,10);
%     r7 = linspace(171,116,10);
%     r8 = linspace(116, 69, 10);
%     r9 = linspace(69, 49, 10);
%     
%     R = [r1, r2, r3, r4, r5, r6, r7, r8, r9];
%     R = R/ 255;
%     
%     g1 = linspace(0,48,10);
%     g2 = linspace(48,109,10);
%     g3 = linspace(109,174,10);
%     g4 = linspace(174,224,10);
%     g5 = linspace(224,243,10);
%     g6 = linspace(243,217,10);
%     g7 = linspace(217,173,10);
%     g8 = linspace(173, 117, 10);
%     g9 = linspace(117, 54, 10);
%     
%     G = [g1, g2, g3, g4, g5, g6, g7, g8, g9];
%     G = G/ 255;
%     
%     b1 = linspace(38,39,10);
%     b2 = linspace(39,67,10);
%     b3 = linspace(67,97,10);
%     b4 = linspace(97,144,10);
%     b5 = linspace(144,248,10);
%     b6 = linspace(248,233,10);
%     b7 = linspace(233,209,10);
%     b8 = linspace(209, 180, 10);
%     b9 = linspace(180, 149, 10);
%     
%     B = [b1, b2, b3, b4, b5, b6, b7, b8, b9];
%     B = B/ 255;
    
    map = [R',G',B'];
    colormap(gca,map);
    %colormap(gca,parula);
    caxis([0.5, 1]);
    set(gca, 'FontSize', 25)
    h = colorbar('southoutside');
    %ylabel(h, 'Confidence', 'FontSize', 32);
    h.Label.String = 'Confidence';
    h.Label.FontSize = 32;
    %set(h,'position',[.1 .17 .01 .7]);
    set(gca,'xtick',[], 'ytick', []);
    set(gca,'xticklabel',[],'yticklabel',[]);
    set(gca,'XColor','none','YColor', 'none');

% Render cells with marching squares if the input image I is a certain 2D image/ mean of uncertain image 
else 
    mask = markAmbiguousCells;
    mask(mask == 0)= NaN;
    imagesc(markAmbiguousCells, 'AlphaData',~isnan(mask)), hold on;
    colormap(gca,gray);
    h = colorbar('southoutside');
    h.Label.String = 'Confidence';
    h.Label.FontSize = 32;
    set(gca, 'FontSize', 25)
    % Set background color
    set(gca,'color',0.85*[1 1 1]);
    set(gca,'xtick',[], 'ytick', []);
    set(gca,'xticklabel',[],'yticklabel',[]);
    set(gca,'XColor','none','YColor', 'none');
end

    %imshow(mostProbableImage), hold on;
    for i=1:length(Objects)
         Points=Objects{i};
         plot(Vertices(Points,2),Vertices(Points,1),'Color',[0 0 0], 'LineWidth', 3.5); hold on
    end
end

function Objects=SortLines2Objects(Lines)
% Object index list
Obj=zeros(100,2); Obj(1,1)=1; nObjects=1; reverse=false;
for i=1:size(Lines,1)-1
    F=Lines(i,2);
    Q=i+1;
    R=find(any(Lines(Q:end,:)==F,2),1,'first');
    if(~isempty(R))
        R=R+i;
        TF=Lines(Q,:);
        if(Lines(R,1)==F),Lines(Q,:)=Lines(R,[1 2]); else Lines(Q,:)=Lines(R,[2 1]); end
        if(R~=Q), Lines(R,:)=TF; end
    else
        F=Lines(Obj(nObjects,1),1);
        R=find(any(Lines(Q:end,:)==F,2),1,'first');
        if(~isempty(R))
            reverse=true;
            Lines(Obj(nObjects,1):i,:)=Lines(i:-1:Obj(nObjects,1),[2 1]);
            R=R+i;
            TF=Lines(Q,:);
            if(Lines(R,1)==F),Lines(Q,:)=Lines(R,[1 2]); else Lines(Q,:)=Lines(R,[2 1]); end
            if(R~=Q), Lines(R,:)=TF; end
        else
            if(reverse)
                Lines(Obj(nObjects,1):i,:)=Lines(i:-1:Obj(nObjects,1),[2 1]);
                reverse=false;
            end
            Obj(nObjects,2)=i;
            nObjects=nObjects+1;
            Obj(nObjects,1)=i+1;
        end
    end
end
Obj(nObjects,2)=i+1;

% Object index list, to real connect object lines
Objects=cell(1,nObjects);
for i=1:nObjects
    % Determine if the line is closed
    if(Lines(Obj(i,1),1)==Lines(Obj(i,2),2)) 
        Objects{i}=[Lines(Obj(i,1):Obj(i,2),1);Lines(Obj(i,1),1)];
    else
        Objects{i}=Lines(Obj(i,1):Obj(i,2),1);
    end
end

% Predict isocontour topology for an ensemble of uncertain 2D data (Img) and estimate confidence of predicted isocontour topology
function [V,F,markAmbiguousCells, mostProbableImage, time, topology]=LookupDB(Img,isovalue, deciderFramework)

% Describe the base-polygons by edges
%  Edge number
%   1
%  ***
% 0* *2
%  ***
%   3
% Marching squares base vertex configurations, [4 4 4 4] denote all
% positive or all negative
I=zeros(16,4);
I(1,:)= [4 4 4 4]; % [0 0;0 0]
I(2,:)= [1 0 4 4]; % [1 0;0 0] 
I(3,:)= [2 1 4 4]; % [0 1;0 0] 
I(4,:)= [2 0 4 4]; % [1 1;0 0] 
I(5,:)= [0 3 4 4]; % [0 0;1 0] 
I(6,:)= [1 3 4 4]; % [1 0;1 0] 
I(7,:)= [2 1 0 3]; % [0 1;1 0] ambiguous
I(8,:)= [2 3 4 4]; % [1 1;1 0] 
I(9,:)= [3 2 4 4]; % [0 0;0 1] 
I(10,:)=[1 0 3 2]; % [1 0;0 1] ambiguous
I(11,:)=[3 1 4 4]; % [0 1;0 1] 
I(12,:)=[3 0 4 4]; % [1 1;0 1] 
I(13,:)=[0 2 4 4]; % [0 0;1 1] 
I(14,:)=[1 2 4 4]; % [1 0;1 1] 
I(15,:)=[0 1 4 4]; % [0 1;1 1] 
I(16,:)=[4 4 4 4]; % [1 1;1 1] 

% The base-edges by vertex positions 
E=[0 0 1 0; 0 0 0 1; 0 1 1 1; 1 0 1 1; 4 4 4 4];

% base-Polygons by vertexpostions 
IE=E(I(:)+1,:);
IE=[IE(1:16,:) IE(17:32,:); IE(33:48,:) IE(49:64,:)];

% Make a Binary image with pixels set to true above iso-treshold
% getMostProbableSignNetwork and collapse ensemble data to mean data for
% purpose of interpolation on edges

copyInputImage = Img;

% Compute most probable signs at each vertex of a 2D grid
[mostProbableImage, B] = getMostProbableSignNetwork(Img, isovalue);

%B=Img>=isovalue;

% Get Elementary Cells
%  Cell
%  1 ** 2
%  *    *
%  *    *
%  4 ** 8
%
B0=B(1:end-1,1:end-1); B1=B(1:end-1,2:end); B2=B(2:end,1:end-1); B3=B(2:end,2:end);

% V is a great matrix! It is literally a 2d matrix representing topology decision (one of the 16 cases above). 
% Find points in V where values is 7 or 10 (marching squares ambiguous
% configuration) and run probabilistic asymptotic decider to modify the V matrix.
V=B0+B1*2+B2*4+B3*8+1;

[posX,posY]=find((V==7)|(V==10)); 
disp('Number of Ambiguous Cells:')
numel(posX)
markAmbiguousCells = zeros(size(mostProbableImage));

% Asymptotic decider in certain field or mean-field for uncertain data
if(strcmp(deciderFramework, 'asymptotic'))
    tic
    V = resolveAmbiguityAsymptoticDecider(V, mostProbableImage, isovalue);
    time = toc;
    topology = V;
    % Mark cells with ambiguous isocontour topology by assigning 1 to their vertices
    for i = 1:length(posX)
        markAmbiguousCells(posX(i),posY(i)) = 1;
        markAmbiguousCells(posX(i)+1,posY(i)) = 1;
        markAmbiguousCells(posX(i)+1,posY(i)+1) = 1;
        markAmbiguousCells(posX(i),posY(i)+1) = 1;
    end
% Midpoint decider in certain field or mean-field for uncertain data
elseif(strcmp(deciderFramework, 'midpoint'))
    tic
    V = resolveAmbiguityMidpointDecider(V, mostProbableImage, isovalue);
    time = toc;
    topology = V;
     % Mark cells with ambiguous isocontour topology by assigning 1 to their vertices
    for i = 1:length(posX)
        markAmbiguousCells(posX(i),posY(i)) = 1;
        markAmbiguousCells(posX(i)+1,posY(i)) = 1;
        markAmbiguousCells(posX(i)+1,posY(i)+1) = 1;
        markAmbiguousCells(posX(i),posY(i)+1) = 1;
    end
% Probabilistic Midpoint Decider (reference [3] in VIS paper) for topology
% resolution in uncertain data
elseif(strcmp(deciderFramework, 'probabilisticMidpoint'))
    tic
    [V, probArr] = resolveAmbiguityProbabilisticMidpointDecider(V, copyInputImage, isovalue);
    time = toc;
    topology = V;
     % Mark cells with ambiguous isocontour topology by assigning probability of resolved topological configuration (7 or 10) to their vertices
    for i = 1:length(posX)
        markAmbiguousCells(posX(i),posY(i)) = probArr(i);
        markAmbiguousCells(posX(i)+1,posY(i)) = probArr(i);
        markAmbiguousCells(posX(i)+1,posY(i)+1) =probArr(i);
        markAmbiguousCells(posX(i),posY(i)+1) = probArr(i);
    end
% Asymptotic Decider (reference [3] in VIS paper) for topology
% resolution in uncertain data
elseif(strcmp(deciderFramework, 'probabilisticAsymptotic'))
    tic
    [V, probArr] = resolveAmbiguityProbabilisticAsymptoticDecider(V, copyInputImage, isovalue);
    time = toc;
    topology = V;
    % Mark cells with ambiguous isocontour topology by assigning probability of resolved topological configuration (7 or 10) to their vertices
    for i = 1:length(posX)
        markAmbiguousCells(posX(i),posY(i)) = probArr(i);
        markAmbiguousCells(posX(i)+1,posY(i)) = probArr(i);
        markAmbiguousCells(posX(i)+1,posY(i)+1) = probArr(i);
        markAmbiguousCells(posX(i),posY(i)+1) =probArr(i);
    end
else
    disp('Invalid decider Framwork!');
end

[x,y]=find((V>1)&(V<16)); 
v=V(x+(y-1)*size(V,1));

% Elementary cells to Edge coordinates defined by connected image grid-points
J=[IE(v,:);IE(v+16,:)];
r=J(:,1)==4;
J=J+[x y x y x y x y;x y x y x y x y];
J(r,:)=[];

% Vertices list defined by connected image grid-points
VP=[J(:,1:4);J(:,5:8)];

% Make a Face list
F=[(1:size(J,1))' (size(J,1)+1:2*size(J,1))'];

% Remove dubplicate vertices
[VP,a,Ind]=unique(VP,'rows'); F=Ind(F);

% Vertices described by image grid-points to real 
% linear Interpolated vertices
Vind1=VP(:,1)+(VP(:,2)-1)*size(mostProbableImage,1);
Vind2=VP(:,3)+(VP(:,4)-1)*size(mostProbableImage,1);
V1=abs(double(mostProbableImage(Vind1))-double(isovalue));
V2=abs(double(mostProbableImage(Vind2))-double(isovalue));
alpha=V2./(V1+V2);
Vx=VP(:,1).*alpha+VP(:,3).*(1-alpha);
Vy=VP(:,2).*alpha+VP(:,4).*(1-alpha);
V=[Vx Vy];





