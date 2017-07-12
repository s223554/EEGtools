clear all;
%% read abf file
Fs = 1000;
[abfFileName,path] = uigetfile('*.abf');
filename = strcat(path,abfFileName);
[LFP1,LFP2] = readABF2ch(filename,'IN 0','IN 5');  % 1 for left, 2 for right
outputdir = strcat(pwd,'\output\');

Fc = [0.5 250];                          % freq limit
filtered1 = bandPass(LFP1,Fc,Fs);
filtered2 = bandPass(LFP2,Fc,Fs);
%%
k = input('How many data points needed ?');
timeInter = 100;        % time interval for analysis, unit = sec.
tvec = 1/Fs:1/Fs:timeInter;
data1 = zeros(timeInter*Fs,k);
data2 = zeros(timeInter*Fs,k);
startTime = zeros(1,k);
for i = 1:k
    startTime(i) = input(strcat('Time for time point ',num2str(i)));
    data1(:,i) = LFP1(startTime(i)*Fs:(startTime(i)+timeInter)*Fs-1);      % one time in one col
    data2(:,i) = LFP2(startTime(i)*Fs:(startTime(i)+timeInter)*Fs-1);       % data1 for control, data2 for 
end
%%
Fc = [0.5 250];   

% params for spectrum calculation.
params.Fs = Fs;
params.fpass = [0 30];
params.tapers=[3 5];
% params.err = [1 2];
[S1,f1] = mtspectrumc(data1,params);
[S2,f2] = mtspectrumc(data2,params);

fitted_S1 = fitMultiCh(f1',S1,'poly9');
plotTraceFreq(data1,tvec,f1,S1,fitted_S1,'oleic acid')