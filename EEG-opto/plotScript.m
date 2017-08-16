subplot(511)
plot(tvec,stim_roi)
xlim([timeStart timeEnd])
subplot(512)
plot_matrix(Spec,t,fspec);
colormap('jet');
caxis([-75 -10]);
colorbar off;
set(gca,'XTick',[])
ylabel('Frequency(Hz)')
xlabel('Time(s)')
subplot(513)
plot(tvec,eeg_roi);
xlim([timeStart timeEnd])
subplot(514)
bar(theta_delta_ratio);            % the delta raw power.
xlim([1 size(prev_delta,1)])
subplot(515)
bar(locs_data)
xlim([0 range(TB)./bin_size])