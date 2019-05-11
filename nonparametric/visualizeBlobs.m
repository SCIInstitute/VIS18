% -------------------------------------------
%   Title: The Probabilistic Asymptotic Decider for Topological Ambiguity Resolution 
%	  in Level-Set Extraction for Uncertain 2D Data.
%   Authors: Tushar Athawale and Chris R. Johnson	
%   Date: 03/01/2019
% ------------------------------------------

% Visualization shown in Fig. 1 of the VIS paper

function  visualizeBlobs()

addpath('helperFunctions/')
rng('default')

% Read Blobs image
I2 = im2double(imread('blobs.png'));
[I2x, I2y] = size(I2);

%% Inject nonparametric noise in Blobs to create an ensemble data

% Get KDE samples assuming mean close to 0 for 9 kernals.
% Samples at a distance 0.1 to 0.3 represent outliers

numKernels = 10;

mean1 = 0.05*rand(1,9);
mean2 = -0.3 - rand(1,1)*0.1;
mean = [mean1, mean2];
bw = getBandwidth(mean);

numMembers = 20;
ensemble = zeros(I2x, I2y, numMembers);

for i=1:I2x
    for j=1:I2y
        noise = getKdeSamples(mean, bw, numMembers);
        ensemble(i,j,:) = I2(i,j) + noise;
    end
end

% isovalue
k = 0.49;

%% GroundTruth Visualization
figure
myIsocontour(I2, k , 'asymptotic');
title('Asymptotic Decider in the Groundtruth Image', 'FontSize', 25);
 %figure
 %myIsocontour(I2, k , 'midpoint');

%% Asymptotic Decider in Mean Field
meanEnsemble = sum(ensemble,3)/numMembers;
figure
myIsocontour(meanEnsemble, k, 'asymptotic');
title('Asymptotic Decider in the Mean of Uncertain Data', 'FontSize', 25);

%% Probabilistic Midpoint Decider
 figure
 myIsocontour(ensemble, k , 'probabilisticMidpoint');
 title('Probabilistic Midpoint Decider in Uncertain Data', 'FontSize', 25);

%% Probabilistic Asymptotic Decider
figure
myIsocontour(ensemble, k , 'probabilisticAsymptotic');
title('Probabilistic Asymptotic Decider in Uncertain Data', 'FontSize', 25);

%% Midpoint Decider in Mean Field
%myIsocontour(ensemble, k , 'midpoint');