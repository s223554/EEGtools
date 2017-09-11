function [eeg emg stim] = readABF( filename,ch1, ch2 )
%READABF Summary of this function goes here
%   read ABF file and return vectors.
%   
    eeg = abfload(char(filename),'channels',{ch1});
    emg = abfload(char(filename),'channels',{ch2});
    
end

