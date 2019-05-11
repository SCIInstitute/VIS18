function probability = getYstrictlyNegativeDistribution(k, a, b, c, d, p, domainContinuous, order, critical, start, finish)

% Initialize probability
probability = 0;

% Non-breaking R domain cases
if (domainContinuous == 1)

    if (strcmp(order,'standard'))
        probability = yNegativeRFiniteStandard(k, a, b, c, d, p, critical, start, finish);
    elseif (strcmp(order,'flipped'))
        probability = yNegativeRFiniteFlipped(k, a, b, c, d, p, critical, start, finish);
    end    
% Breaking R domain cases
% In case of breaking domain space between start and finish is empty
elseif (~domainContinuous)
    
    if (strcmp(order,'standard'))
        probability = yNegativeRInfiniteStandard(k, a, b, c, d, p, critical, start, finish);
    elseif (strcmp(order,'flipped'))
        probability = yNegativeRInfiniteFlipped(k, a, b, c, d, p, critical, start, finish);
    end
    
end