% Draw samples from input kernel density function
% meanArr: kernel centers
% bw: kernel bandwidth estimated using the Silverman's rule of thumb
% numSamples: Number of samples needed to be drawn from the distribution

function samples = getKdeSamples(meanArr, bw, numSamples)

l = length(meanArr);
samples = zeros(1, numSamples);

for i = 1: numSamples

% select a kernel at random
kernelPick = randi(l);
a = meanArr(1,kernelPick) - bw;
b = meanArr(1,kernelPick) + bw;

% uniRand: draw from uniform distribution
% the function is located in helperFunctions directory
samples(i) = uniRand(a, b,1);

end