clear all;
%% read abf file
Fs = 2010;
[abfFileName,path] = uigetfile('*.abf');
filename = strcat(path,abfFileName);
[EEG,EMG,STIM] = readABF(filename,'IN 14','IN 15','IN 12');  % 1 for left, 2 for right , 3 for stimulation5
outputdir = strcat(pwd,'\output\');

Fc = [0.5 500];                          % freq limit
filteredEEG = bandPass(EEG,Fc,Fs);
%%
timeStart = input('Start time (sec)?');       % time interval for analysis, unit = sec.
timeEnd = input('End time (sec)?'); 
tvec = (timeStart+1/Fs:1/Fs:timeEnd);
eeg_roi = EEG(timeStart*Fs:(timeEnd)*Fs-1); 
emg_roi = EMG(timeStart*Fs:(timeEnd)*Fs-1); 
stim_roi = STIM(timeStart*Fs:(timeEnd)*Fs-1); 
% spectrum
Fc = [0.5 250];   
% params for spectrum calculation.
params.Fs = Fs;
params.fpass = [0 50];
params.tapers=[3 5];
% params.err = [1 2];
[S,f] = mtspectrumc(eeg_roi,params);
plot(f,S)

% ylim([-0.2 1]*0.001)
%%
epoch = 3;
step = 3;
movingwin=[epoch step]; 
[Spec,t,fspec]=mtspecgramc(eeg_roi,movingwin,params);

Palpha = sum(Spec(:,8<fspec&fspec<13),2);
Ptheta = sum(Spec(:,4<fspec&fspec<8),2);
Pdelta = sum(Spec(:,0.5<fspec&fspec<4),2);
Ptotal = sum(Spec,2);
theta_delta_ratio = Ptheta./Pdelta;
prev_delta = Pdelta/Ptotal;

subplot(411)
plot(tvec,stim_roi)
subplot(412)
plot_matrix(Spec,t,fspec);
colormap('jet');
caxis([-75 -10]);
colorbar off;
set(gca,'XTick',[])
ylabel('Frequency(Hz)')
xlabel('Time(s)')
subplot(413)
plot(tvec,eeg_roi);
subplot(414)
plot(prev_delta);
xlim([1 size(prev_delta,1)])