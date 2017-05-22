function [ locs ] = spikeCount( data,interval,gain )
%SPIKECOUNT Summary of this function goes here
%   Need peakseek.m and snle.m
data_snle = snle(data',ones(1,length(data)));
%final = bsxfun(@minus,y_snle,mean(y_snle,2)); %zero mean
thres = gain * mean(median(abs(data_snle)),2);
[locs] = peakseek(data_snle,interval,thres);
end

