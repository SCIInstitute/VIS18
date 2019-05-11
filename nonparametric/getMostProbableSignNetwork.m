% im: Ensemble of 2D uncertain functions
% k: isovalue
% img: Stores the mean of ensemble
% B: stores the most probable sign at grid vertices

function [img, B] = getMostProbableSignNetwork(im, k)

% 2D certain image/ 2D mean image
if(ndims(im)==2)
    B=im>=k;
    img = im;

% Ensemble of uncertain 2D images
elseif(ndims(im)==3)   
   
% Serial implementation for computing the most probable sign using
% Kernel density estimation (KDE)
%     [a, b, c] = size(im);
%     negativeProb = zeros(a*b,1);
%     parfor id = 1:a*b
% %     for i=1:a
% %         for j=1:b
%                 [i,j] = ind2sub([a b], id);
%                 members = squeeze(im(i,j,:));
%                 % perform kde on memebers and get the most probable sign
%                 bw = getBandwidth(members);
%                 pts = linspace(min(members)-bw, max(members) + bw, 5000);
%                 pdf = ksdensity(members, pts, 'Bandwidth', bw,'Kernel', 'box');
%                 normalizedPdf = pdf/sum(pdf);
%                 % Find probability: Pr(pdf<isovalue)
%                 negativeProb(id) = sum(normalizedPdf(find(pts<k)));            
%     end
% %         end
% %     end
%     negProbArray =  reshape(negativeProb, [a, b]);
%      B=negProbArray<0.5;
    
    % Expected sign for kde is same as the mean of samples
%     img = mean(im,3);
%     B=img>=k;

% Parallel implementation for computing the most probable sign using
% Kernel density estimation (KDE)
    [a, b, c] = size(im);
    negativeProb = zeros(a*b,1);
    parfor id = 1:a*b
                [i,j] = ind2sub([a b], id);
                members = squeeze(im(i,j,:));
                % Kernel bandwidth estimation
                bw = getBandwidth(members);
                % Find probability: Pr(pdf<isovalue)
                negativeProb(id) = getNegativeSignProbKde(members, bw, k);            
    end

    negProbArray =  reshape(negativeProb, [a, b]);
    % If the most probable vertex sign is positive, assign 1 in the binary grid
    B=negProbArray<0.5;         
    img = mean(im,3);
else
    disp('Image dimension can not exceed 3');
end
