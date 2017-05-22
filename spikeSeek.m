function [ locs spks] = spikeSeek( data,interval,thresGain )
%SPIKESEEK Summary of this function goes here
%   Just use raw threshold

thres = thresGain * std(data);
[locs1 spks1] = peakseek(data,interval,thres);
[locs2 spks2] = peakseek(-data,interval,thres);
locs = [locs1,locs2];
spks = [spks1,-spks2];
end

