Fs = 1000;
[abfFileName,path] = uigetfile('*.abf');
filename = strcat(path,abfFileName);
[LFP1 LFP2] = readABF2ch(filename,'IN 0','IN 5');  % 1 for left, 2 for right
outputdir = '.\output\';

Fc = [0.5 250];                          % freq limit
filtered1 = bandPass(LFP1,Fc,Fs);
filtered2 = bandPass(LFP2,Fc,Fs);
%%
k = input('How many data points needed ?');
timeInter = 100;        % time interval for analysis, unit = sec.
data1 = zeros(timeInter*Fs,k);
data2 = zeros(timeInter*Fs,k);
for i = 1:k
    startTime = input(strcat('Time for time point ',num2str(i)));
    data1(:,i) = LFP1(startTime*Fs:(startTime+timeInter)*Fs-1); % one time in one col
    data2(:,i) = LFP2(startTime*Fs:(startTime+timeInter)*Fs-1);
end

% params for spectrum calculation.
params.Fs = Fs;
params.fpass = [0 250];
params.tapers=[3 5];
movingwin=[20 20];              % moving window and moving steps

[Spec1,t1,fspec1]=mtspecgramc(data1,movingwin,params);
PowerDelta = sum(Spec(:,1<fspec1&fspec1<4,:).^2,2);
PowerSum = sum(Spec.^2,2);
