Tstart = 19144212;
Tend = 20344212;
Tstartle = 19442465;
duration  = Tend-Tstart;
durationbins = 60;  %duration in sec
H = hist(VarName14/1000,floor(duration/1000/durationbins));
hist(VarName14/1000,floor(duration/1000/durationbins));
line([Tstartle/1000 Tstartle/1000],[0 100]);
ylim([0 30])

bar(H);
a = H';
