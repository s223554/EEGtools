clear all;
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
data1 = zeros(timeInter*Fs,k);
data2 = zeros(timeInter*Fs,k);
startTime = zeros(1,k);
for i = 1:k
    startTime(i) = input(strcat('Time for time point ',num2str(i)));
    data1(:,i) = LFP1(startTime(i)*Fs:(startTime(i)+timeInter)*Fs-1);      % one time in one col
    data2(:,i) = LFP2(startTime(i)*Fs:(startTime(i)+timeInter)*Fs-1);
end

% params for spectrum calculation.
params.Fs = Fs;
params.fpass = [0 250];
params.tapers=[3 5];
epoch = 20;
step = 20;
movingwin=[epoch step];              % moving window and moving steps
N_epochs = timeInter/epoch;

[Spec1,t1,fspec1]=mtspecgramc(data1,movingwin,params);  % spec is already power
[Spec2,t2,fspec2]=mtspecgramc(data2,movingwin,params);
raw1 = SpecSeperate(Spec1,fspec1);
raw2 = SpecSeperate(Spec2,fspec2);

prev1 = raw1./repmat(sum(raw1,2),1,4,1);
prev2 = raw2./repmat(sum(raw2,2),1,4,1);
raw_factors = sum(raw2,1)./sum(raw1,1);
prev_factors = sum(prev2,1)./sum(prev1,1);

col_names = 1:N_epochs;
%col_header = {'1','2','3','4','5','1','2','3','4','5'};
%col_header = repmat(col_names,1,2);
col_header = [num2cell(repmat(col_names,1,2)) {'factors(durg/control)'}];
%col_header = transpose(num2cell(strread(num2str(repmat(col_names,1,2)),'%s')));

row_header(1:8,1)={'Delta_Prev','Theta','Alpha','Beta & Beyond','Delta_Raw','Theta','Alpha','Beta & Beyond'};
for j = 1:k
    prev_cell = num2cell([prev1(:,:,j)' prev2(:,:,j)']);
    raw_cell = num2cell([raw1(:,:,j)' raw2(:,:,j)']);
    output_matrix=[{' '} col_header; row_header [prev_cell num2cell(prev_factors(:,:,j)');raw_cell num2cell(raw_factors(:,:,j)')]];
    xlswrite(strcat(outputdir,abfFileName,'.xlsx'),output_matrix,j);
end
xlsSheetRename(strcat(outputdir,abfFileName,'.xlsx'),startTime);