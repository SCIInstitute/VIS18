function compareDecisions()
addpath('helperFunctions/')
numSamples = 200;
trackSign = zeros(numSamples,8);
karr = linspace(3.5,4.7, numSamples);

for i =1:numSamples
    k = karr(i);
[signProbabilisticSaddle, signProbabilisticMid, signMeanSaddle, signMeanMid, signGtSaddle, signGtMean, probSaddle, probMid] = compareSaddleMidpoint(k, 'no', 'no'); 
 temp = [signGtSaddle, signGtMean, signProbabilisticSaddle, signProbabilisticMid, signMeanSaddle, signMeanMid, probSaddle, probMid];
 trackSign(i,:) = temp;
end

figure

subplot(3,2,1);
stairs(karr, trackSign(:,1), 'LineWidth',2);
xlabel('k',  'FontSize', 25) % x-axis label
ylabel('Sign',  'FontSize', 25) % y-axis label
ntitle('GAD', 'FontSize', 24, 'location', 'southeast')

subplot(3,2,2);
stairs(karr, trackSign(:,2), 'LineWidth',2);
xlabel('k',  'FontSize', 25) % x-axis label
ylabel('Sign',  'FontSize', 25) % y-axis label
ntitle('GMD', 'FontSize', 24, 'location', 'southeast')

subplot(3,2,3);
stairs(karr, trackSign(:,3), 'LineWidth',2);hold on;
for i = 1:numSamples
    p1=plot([karr(i), karr(i)],  [0, trackSign(i,7)], 'LineWidth',2.46, 'Color', 'r'); 
    p1.Color(4) = 0.3;
    hold on;
end
xlabel('k',  'FontSize', 25) % x-axis label
ylabel('Sign',  'FontSize', 25) % y-axis label
ntitle('PAD', 'FontSize', 24, 'location', 'southeast', 'location', 'southeast');

subplot(3,2,4);
stairs(karr, trackSign(:,4), 'LineWidth',2); hold on;
for i = 1:numSamples
    p1=plot([karr(i), karr(i)],  [0, trackSign(i,8)], 'LineWidth',2.46, 'Color', 'r'); 
    p1.Color(4) = 0.3;
    hold on;
end
xlabel('k',  'FontSize', 25) % x-axis label
ylabel('Sign',  'FontSize', 25) % y-axis label
ntitle('PMD','FontSize', 24, 'location', 'southeast')

subplot(3,2,5);
stairs(karr, trackSign(:,5), 'LineWidth',2);
xlabel('k',  'FontSize', 25) % x-axis label
ylabel('Sign',  'FontSize', 25) % y-axis label
ntitle('MAD','FontSize', 24, 'location', 'southeast')

subplot(3,2,6);
stairs(karr, trackSign(:,6), 'LineWidth',2);
xlabel('k',  'FontSize', 25) % x-axis label
ylabel('Sign',  'FontSize', 25) % y-axis label
ntitle('MMD', 'FontSize', 24, 'location', 'southeast')