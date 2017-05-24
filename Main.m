clear all;
%% read abf file
Fs = 1000;
[abfFileName,path] = uigetfile('*.abf');
filename = strcat(path,abfFileName);
[eeg emg stimuli] = readABF(filename,'IN 14','IN 15','IN 12');
outputdir = '.\output\';
%% save mat and preprocessing(filtering)
save(abfFileName,'eeg','emg','stimuli');
Fc = [0.5 40];                          % freq limit
filteredEEG = bandPass(eeg,Fc,Fs);
%% find stimuli and extract the epoches
negative = input('negative?(1 for negative)');
if negative == 1
    stim = -stimuli;
else
    stim = stimuli;
end
stim_loc = findStim( stim,Fs,[0.05 0.1 0.15 0.2]);
% create a matrix of data extract vector of epochs in column
% pass time boundary in sec.
TB = [-120 120];            % Time boundary
tvec = TB(1):1/Fs:TB(2)-1/Fs;
eeg_epochs = extractEpoch(filteredEEG,stim_loc,Fs,TB); 
emg_epochs = extractEpoch(emg,stim_loc,Fs,TB); 
%% calculate 
% spikes counting
minInterval = 0.05*Fs;
thresGain = 100;      % for thresholding ~5, for snle ~60
% spectrogram
params.Fs = Fs;
params.fpass = [0 20];
params.tapers=[3 5];

bin_size = 10;          %in sec

index_save = 1;
for i = 1:length(stim_loc)
tmp = eeg_epochs(:,i);
mtmp = emg_epochs(:,i);
locs = spikeCount(tmp,minInterval,thresGain);
% locs = spikeSeek(tmp,minInterval,thresGain);
h = histogram(locs,'BinLimits',[0 range(TB)*Fs],'NumBins',range(TB)./bin_size);        % 10 secs bin size
loc_tmp = h.Values; 
close;

%[S,f]=mtspectrumc(tmp,params);
movingwin=[5 0.5];              % moving window and moving steps
[Spec,t,fspec]=mtspecgramc(tmp,movingwin,params);

% theta/delta power ratio.
Ptheta = sum(Spec(:,4<fspec&fspec<8).^2,2);
Pdelta = sum(Spec(:,0.5<fspec&fspec<4).^2,2);
theta_delta_ratio = Ptheta./Pdelta;

% plot and save
plotStartle(tmp,mtmp,TB,tvec,locs,theta_delta_ratio,Spec,t,fspec,bin_size,Fs)
if 0 == input('Discard the stimulus? Yes = 1')
loc_all(:,index_save) = loc_tmp;
tdr_all(:,index_save)= theta_delta_ratio;
print(gcf,strcat(outputdir,abfFileName, '_','startle_',num2str(i),'.tif'),'-dtiff');
index_save = index_save +1;
end
close;
end
plotAverage(tdr_all,loc_all,TB)
save(strcat(outputdir,abfFileName,'.mat'),'tdr_all','loc_all')