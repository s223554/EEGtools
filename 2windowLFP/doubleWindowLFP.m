Fs = 1000;
[abfFileName,path] = uigetfile('*.abf');
filename = strcat(path,abfFileName);
[LFP1 LFP2] = readABF2ch(filename,'IN 0','IN 5');  % 1 for left, 2 for right
outputdir = '.\output\';

Fc = [0.5 40];                          % freq limit
filtered1 = bandPass(LFP1,Fc,Fs);
filtered2 = bandPass(LFP2,Fc,Fs);

timeInter = 100;        % time interval for analysis.
startTime1 = input('Time before loading drugs');
startTime2 = input('Time after loading drugs');

data = zeros(timeInter*Fs,4);
data(:,1) = LFP1(startTime1*Fs:(startTime1+timeInter)*Fs-1);  % left channel before drug applies
data(:,2) = LFP2(startTime1*Fs:(startTime1+timeInter)*Fs-1);  % right channel before drug applies
data(:,3) = LFP1(startTime2*Fs:(startTime2+timeInter)*Fs-1);  % left channel after drug applies
data(:,4) = LFP2(startTime2*Fs:(startTime2+timeInter)*Fs-1);  % right channel before drug applies

% params for spectrum calculation.
params.Fs = Fs;
params.fpass = [0 40];
params.tapers=[3 5];
movingwin=[10 10];              % moving window and moving steps
[Spec,t,fspec]=mtspecgramc(data,movingwin,params);
PowerDelta = sum(Spec(:,0.5<fspec&fspec<4,:).^2,2);
PD(:,:) = PowerDelta(:,1,:);
bar(PD');
set(gca, 'XTick', [1 2 3 4])
set(gca, 'XTickLabel', {'left baseline' 'right baseline' 'left fatty acid' 'right fatty acid'})
xlswrite(strcat(outputdir,abfFileName,'.xlsx'),PD);