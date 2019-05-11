function [errorMid, errorAsymp] = computeTopologicalError(topologyGroundTruth, topologyMid, topologyAsymp)

[posMidX,posMidY]=find((topologyMid==7)|(topologyMid==10));
[posAsympX,posAsympY]=find((topologyAsymp==7)|(topologyAsymp==10));

% Error in midpoint decider topology
idx = sub2ind(size(topologyGroundTruth), posMidX, posMidY);
errorMid = numel(find(topologyGroundTruth(idx)~=topologyMid(idx)));

% Error in asymptotic decider topology
idx = sub2ind(size(topologyGroundTruth), posAsympX, posAsympY);
errorAsymp = numel(find(topologyGroundTruth(idx)~=topologyAsymp(idx)));
