function [ output_args ] = plotStartle( data,TB,tvec,locs,theta_delta_ratio,Spec,t,fspec,bin_size,Fs)
%PLOTSTARTLE Summary of this function goes here
%   bin_size in sec; TB Time boundary
%   Spec,t,fspec from mtspecgramc
figure;
set(gcf,'Position',[100 100 1000 600])

subplot(4,1,1)
plot(tvec,data)
xlim(TB)
ylim([-1 1])
ylabel('mV')

subplot(4,1,2)
h = histogram(locs,'BinLimits',[0 range(TB)*Fs],'NumBins',range(TB)./bin_size);        % 10 secs bin size
bar(h.Values)
% xlim([0 range(TB)./bin_size])
set(gca,'XTick',[])
ylabel('Spikes / 10s')

subplot(4,1,3)      % theta/delta
Q = size(theta_delta_ratio,1);
P = range(TB);
tdr = resample(theta_delta_ratio,P,Q);
plot(TB(1):TB(2)-1,tdr)
xlim(TB)
ylim([-1 3])
ylabel('Theta / Delta')

subplot(4,1,4)
plot_matrix(Spec,t,fspec);
colormap('jet');
caxis([-70 -10]);
colorbar off;
set(gca,'XTick',[])
ylabel('Frequency(Hz)')
xlabel('Time(s)')
end

