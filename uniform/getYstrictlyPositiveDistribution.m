function probability = getYstrictlyPositiveDistribution(k, a, b, c, d, p, domainContinuous, order, critical, start, finish)

% Initialize probability
probability = 0;


% Non-breaking R domain cases
if (domainContinuous == 1)

    if (strcmp(order,'standard'))
        probability = yPositiveRFiniteStandard(k, a, b, c, d, p, critical, start, finish);
    elseif (strcmp(order,'flipped'))
        probability = yPositiveRFiniteFlipped(k, a, b, c, d, p, critical, start, finish);
    end    
% Breaking R domain cases
% In case of breaking domain space between start and finish is empty
elseif (~domainContinuous)
    
    if (strcmp(order,'standard'))
        probability = yPositiveRInfiniteStandard(k, a, b, c, d, p, critical, start, finish);
    elseif (strcmp(order,'flipped'))
        probability = yPositiveRInfiniteFlipped(k, a, b, c, d, p, critical, start, finish);
    end
    
end



