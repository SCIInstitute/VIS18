function recordTimingPerformance()
addpath('helperFunctions/')
rng('default')

I2 = im2double(imread('blobs.png'));
[I2x, I2y] = size(I2);

% Groudtruth
% Asymotic Decider Visualization


% Midpoint Visualization

%--------------------------------------------------
% Noisy data

%% Inject noise to create an ensemble data

% Get KDE samples assuming mean as 0.
% In KDE most of the sample are close to 0
% Samples in the range 0.1 to point 0.3 are outliers

% KDE distribution
mean1 = 0.05*rand(1,9);
mean2 = -0.3 - rand(1,1)*0.1;
mean = [mean1, mean2];
bw = getBandwidth(mean);

% Array to store time
% numMembers: number of noise samples
numMembers = 5:5:40;
timeArrProbMid = zeros(numel(numMembers),1);
timeArrProbAsymp= zeros(numel(numMembers),1);
errorProbMid = zeros(numel(numMembers),1);
errorProbAsymp = zeros(numel(numMembers),1);

% Sample KDE distribution to get noise samples.
for id=1:numel(numMembers)
    ensemble = zeros(I2x, I2y, numMembers(id));
    for i=1:I2x
        for j=1:I2y
            noise = getKdeSamples(mean, bw, numMembers(id));
            ensemble(i,j,:) = I2(i,j) + noise;
        end
    end
    
    %% GroundTruth Visualization
    [Lines,Vertices,Objects, time, topologyGroundTruth] = myIsocontour(I2, 0.49, 'asymptotic');
    
    %% Asymptotic Decider in Mean Field
    %myIsocontour(ensemble, 0.49, 'asymptotic');
    
    %% Probabilistic Midpoint Decider
    [Lines,Vertices,Objects, time, topologyMid] = myIsocontour(ensemble, 0.49, 'probabilisticMidpoint');
    timeArrProbMid(id) = time;
    %% Probabilistic Asymptotic Decider

    [Lines,Vertices,Objects, time, topologyAsymp] = myIsocontour(ensemble, 0.49, 'probabilisticAsymptotic');
    timeArrProbAsymp(id) = time;
    
    %% Midpoint Decider in Mean Field
    %myIsocontour(ensemble, 0.49, 'midpoint');
    
    [errorMid, errorAsymp] = computeTopologicalError(topologyGroundTruth, topologyMid, topologyAsymp);
    % Record Error
    errorProbMid(id) = errorMid;
    errorProbAsymp(id) = errorAsymp;
end

close all

% Time plot
figure
subplot(1,2,1)
plot(numMembers, timeArrProbMid, 'LineWidth', 6); hold on
plot(numMembers, timeArrProbAsymp, 'LineWidth', 6); hold on
xlabel('Number of ensemble members', 'FontSize', 33); % x-axis label
ylabel('Time (in seconds)', 'FontSize', 33); % y-axis label
lgd = legend('Probabilistic Midpoint Decider','Probabilistic Asymptotic Decider','Location','northwest');
lgd.FontSize = 30;
set(gca,'FontSize',30);
set(gca,  'fontweight' , 'bold', 'LineWidth', 1)

subplot(1,2,2)
%figure
% Error plot
plot(numMembers, errorProbMid, 'LineWidth', 6); hold on
plot(numMembers, errorProbAsymp, 'LineWidth', 6); hold on
xlabel('# Ensemble members', 'FontSize', 33); % x-axis label
ylabel('Topological Error (# Cells)', 'FontSize', 33); % y-axis label
lgd = legend('Probabilistic Midpoint Decider','Probabilistic Asymptotic Decider','Location','northwest');
lgd.FontSize = 30;
set(gca,'FontSize',30);
set(gca,  'fontweight' , 'bold', 'LineWidth', 1)