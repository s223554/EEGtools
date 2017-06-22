function [ filteredData ] = bandPass(data,Fc,Fs)
%BANDPASS Summary of this function goes here
%   Butter bandpass filtering
[b,a] = butter(4, Fc./(Fs/2));
filteredData = filtfilt(b,a,double(data));

end

