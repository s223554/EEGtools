function [ stim_loc ] = findStim( stim,Fs,slidewindows)
%FINDSTIM Summary of this function goes here
%   sliding windows (sws) are width of stimulus pulse in unit of second
sws = slidewindows.*Fs;
% fill repeated pulses up to one pulse

for i = 1:length(stim)-max(sws)
    for j = 1:length(sws)
        if(stim(i)>5 && stim(i+sws(j))>5)
            stim(i:i+sws(j)) = stim(i);
        end
    end
end

stim_index = stim>5;
stim_times = 0;
stim_loc = [];
for i = 1:(length(stim_index)-1)
    if stim_index(i+1)-stim_index(i)==1
       stim_times =  stim_times+1;
       stim_loc(stim_times) = i;
    end
end

end

