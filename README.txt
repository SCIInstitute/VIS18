% ----------------------------------------------------------------------------------
%   Title: The Probabilistic Asymptotic Decider for Topological Ambiguity Resolution 
%	  in Level-Set Extraction for Uncertain 2D Data.
%   Authors: Tushar Athawale and Chris R. Johnson	
%   Date: 05/11/2019
% ---------------------------------------------------------------------------------------

Required step:
Add the helperFunctions folder to the MATLAB path before running any of the following driver files

Directories:
parametric: The code for single pair of uniform noise distributions (Section 5.1 in the paper)
nonparametric: The code for nonparametric noise distributions (Section 5.2 in the paper)

a) 'nonparametric' directory (Contains the VIS paper code)

---------
Driver files:

- Visualization of synthetic dataset (Fig. 1 VIS paper)
visualizeBlobs.m
** Note: please maximize the result image, and use a zoom-in tool in MATLAB figure window. 

- Visualization of real datasets (Fig. 12b VIS paper)
visualizeFlow.m (Visualization of flow simulations (karman vortex street). The dataset is courtesy of the Gerris project)
** Note: play with aspect ratio of MATLAB figure window. 

- Timing and Accuracy comparison of probabilistic mipoint vs. probabilistic asymptotic decider (Fig. 11 VIS paper)
recordTimingPerformance.m
** Note: May consume about 15 mins to get result figures 

- Compare decisions of different decider frameworks (Fig. 10 VIS paper)
compareDecisions.m

--------------
% The code tree for isocontour visualization in uncertain data:

myIsocontour.m [the main file for computing probabilistic asysmptotic decisions]

 -> resolveAmbiguityAsymptoticDecider.m (resolve ambiguity for mean/certain field using asymptotic decider)
      -> getGroundTruthSign.m (get signs in the cell interior using asymptotic/midpoint deciders) 	
 -> resolveAmbiguityMidpointDecider.m (resolve ambiguity for the mean/certain field using midpoint decider)
      -> getGroundTruthSign.m (get signs in the cell interior using asymptotic/midpoint deciders)	
 -> resolveAmbiguityProbabilisticAsymptoticDecider.m (resolve ambiguity for uncertain field using probabilistic asymptotic decider)
      -> getMostProbableSignNetwork.m  (Most probable signs for distribution data: parallel implementation)
      	    -> getBandwidth.m (bandwidth estimation for nonparametric density)
      	    -> getNegativeSignProKde (compute probability of vertex beign negative (data < isovalue) for nonparametric density)	
      -> saddleKdeDistribution.m (Find distribution of uncertain saddle values)  
            -> getPKdeDensity.m, getQkdeDensity.m (get distributions of random variables P and Q (See Equation 6 in the paper))
            	    -> getAnalyticalKdeDistribution (get distribition for P or Q for kernel density functions of X and Y)
				-> getSinglePairDistribution (compute distribution of P or Q for a pair of single kernel of X and single kernel of Y)
					-> getRdensityDomain (Compute probability distribution of a random variable R, Equation 10 in the paper)
					-> getYstrictlyPositiveDistribution (when the range of a random variable Y is strictly positive)
						-> yPositiveRFiniteStandard (Y strictly positive, finite support for R)
						-> yPositiveRFiniteFlipped  (Y strictly positive, finite support for R with inverted range)
						-> yPositiveRInfiniteStandard (Y strictly positive, infinite support for R)
						-> yPositiveRInfiniteFlipped (Y strictly positive, infinite support for R with inverted range)
					-> getYcrossingDistribution (when the range of a random variable Y crosses zero)
						-> yCrossingRFiniteStandard (Y range crossing zero, finite support for R)
						-> yCrossingRFiniteFlipped  (Y range crossing zero, finite support for R with inverted range)
						-> yCrossingRInfiniteStandard (Y range crossing zero, infinite support for R)
						-> yCrossingRInfiniteFlipped (Y range crossing zero, infinite support for R with inverted range)
					-> getYstrictlyNegativeDistribution (when the range of a random variable Y is strictly negative)
						-> yNegativeRFiniteStandard (Y strictly negative, finite support for R)
						-> yNegativeRFiniteFlipped  (Y strictly negative, finite support for R with inverted range)
						-> yNegativeRInfiniteStandard (Y strictly negative, infinite support for R)
						-> yNegativeRInfiniteFlipped (Y strictly negative, infinite support for R with inverted range)
 -> resolveAmbiguityProbabilisticMidpointDecider.m (resolve ambiguity for uncertain field using probabilistic midpoint decider)
      -> midpointKdeDistribution.m (Find distribution of uncertain Midpoint values)


Reference implementations (not required for running driver files. Represent cases shown in Appendix 1 and 2.):
simplifiedFiniteDomainPieces.m (Computation of the integrations in Eq. 11-13 when the domain of R is finite) 
simplifiedInfiniteDomainPieces.m (Computation of the integrations in Eq. 11-13 when the domain of R is infinite)


b) 'uniform' directory (Contains code for computing distributions of random variables P and Q for a single pair of uniform kernels). The code is more for debugging purposes.
Contains functionality similar to getSinglePairDistribution function in the nonparametric directory.

---------
Driver files:

kXpluskYplusXY.m, compareSaddleMidpoint.m:  plot distributions similar to ones shown in Fig. 8 of the VIS paper


