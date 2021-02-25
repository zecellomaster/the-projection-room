% Main.m
% Author: Zecellomaster
% This script acts as a main function for the forcast model and allows for
% a concise way to deploy the multitple scripts it relies on.

run PollingAccumulator.m
run PollAverages.m
run FinalVoteShare.m
run ChanceEstimator.m
