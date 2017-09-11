function [eeg emg stim] = readABF( filename,ch1, ch2, ch3 )
%READABF Summary of this function goes here
%   read ABF file and return vectors.
%   
    eeg = abfload(char(filename),'channels',{ch1});
    emg = abfload(char(filename),'channels',{ch2});
    stim = abfload(char(filename),'channels',{ch3});
end

