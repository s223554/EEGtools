function [ output_args ] = plotAverage(tdr_all,loc_all,TB,bin_size)
%PLOTAVERAGE Summary of this function goes here
%   Detailed explanation goes here
tdr_avg = mean(tdr_all,2);
loc_avg = mean(loc_all,2);

figure;
set(gcf,'Position',[100 100 1000 400])

subplot(2,1,1)
bar(loc_avg,'FaceColor',[0 .8 .8]);hold on;
fit = locfit((1:(TB(2)-TB(1))/bin_size)',loc_avg,'deg', 3, 'nn',0.35);
lfplot(fit)
lfband(fit)
set(gca,'XTick',[])
ylabel('Spikes / 10s')


subplot(2,1,2)      % theta/delta
Q = size(tdr_avg,1);
P = range(TB);
tdr = resample(tdr_avg,P,Q);
plot(TB(1):TB(2)-1,tdr)
xlim(TB)
ylim([-1 3])
ylabel('Theta / Delta')

end

