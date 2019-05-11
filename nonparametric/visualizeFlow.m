% -------------------------------------------
%   Title: The Probabilistic Asymptotic Decider for Topological Ambiguity Resolution 
%	  in Level-Set Extraction for Uncertain 2D Data.
%   Authors: Tushar Athawale and Chris R. Johnson	
%   Date: 03/01/2019
% ------------------------------------------

% Visualization shown in Fig. 12 b of the VIS paper

addpath('helperFunctions/')

% Read uncertain flow data
% flow data is courtesy of the Gerris software.
f1 =  double(imread('data/velocity/sim2/m1.png'));
f2 =  double(imread('data/velocity/sim2/m2.png'));
f3 =  double(imread('data/velocity/sim2/m3.png'));
f4 =  double(imread('data/velocity/sim2/m4.png'));
f5 =  double(imread('data/velocity/sim2/m5.png'));
f6 =  double(imread('data/velocity/sim2/m6.png'));
f7 =  double(imread('data/velocity/sim2/m7.png'));
f8 =  double(imread('data/velocity/sim2/m8.png'));
f9 =  double(imread('data/velocity/sim2/m9.png'));
f10 =  double(imread('data/velocity/sim2/m10.png'));
f11 =  double(imread('data/velocity/sim2/m11.png'));
f12 =  double(imread('data/velocity/sim2/m12.png'));
f13 =  double(imread('data/velocity/sim2/m13.png'));
f14 =  double(imread('data/velocity/sim2/m14.png'));
f15 =  double(imread('data/velocity/sim2/m15.png'));

save data/matVelocity/f1.mat f1;
save data/matVelocity/f2.mat f2;
save data/matVelocity/f3.mat f3;
save data/matVelocity/f4.mat f4;
save data/matVelocity/f5.mat f5;
save data/matVelocity/f6.mat f6;
save data/matVelocity/f7.mat f7;
save data/matVelocity/f8.mat f8;
save data/matVelocity/f9.mat f9;
save data/matVelocity/f10.mat f10;
save data/matVelocity/f11.mat f11;
save data/matVelocity/f12.mat f12;
save data/matVelocity/f13.mat f13;
save data/matVelocity/f14.mat f14;
save data/matVelocity/f15.mat f15;


pcheck = cat(3, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15);


% Visualize isocontours using probabilistic midpoint and asymptotic
% deciders 
isov = 25;
figure
myIsocontour(pcheck, isov, 'probabilisticMidpoint');
figure
myIsocontour(pcheck, isov, 'probabilisticAsymptotic');
