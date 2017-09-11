function [ epochs ] = extraceEpoch(data,stim_loc,Fs,time_boundary)
%EXTRACEEPOCH Summary of this function goes here
%   
epochs = zeros(abs(time_boundary(2)-time_boundary(1))*Fs,length(stim_loc));
for i = 1:length(stim_loc)
    try
    epochs(:,i) = data((stim_loc(i)+time_boundary(1)*Fs:(stim_loc(i)+time_boundary(2)*Fs-1)));
    catch
        continue
    end
end

end

