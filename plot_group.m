clear;
[tdrs spike_distr] = concateStartles;
TB = [-120 120];            % Time boundary

plotAverage(tdrs,spike_distr,TB)

% bar(mean(spike_distr,2));hold on
% fit=locfit((1:24)',mean(spike_distr,2),'deg', 3, 'nn',0.35)
% lfplot(fit)
% lfband(fit)