function [tdr loc]= concateStartles()
path = uigetdir();
home = pwd;
cd(path)
tdr = [];
loc = [];
files = dir('*.mat');
for f = 1:numel(files)
    load(files(f).name)
    tdr = [tdr tdr_all];
    loc = [loc loc_all];
end
cd(home)
end
