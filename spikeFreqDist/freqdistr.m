Tstart = 6434753;
Tend = 8241453;
Tstartle = 7033643;
duration  = Tend-Tstart;
durationbins = 60;
H = hist(VarName1/1000,floor(duration/1000/durationbins));
hist(VarName1/1000,floor(duration/1000/durationbins));
line([Tstartle/1000 Tstartle/1000],[0 100]);
ylim([0 30])

bar(H);
a = H';
