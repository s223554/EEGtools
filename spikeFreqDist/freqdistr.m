Tstart = 6564130;
Tend = 7764310;
Tstartle = 6864479;
duration  = Tend-Tstart;
durationbins = 60;  %duration in sec
H = hist(VarName7/1000,floor(duration/1000/durationbins));
hist(VarName7/1000,floor(duration/1000/durationbins));
line([Tstartle/1000 Tstartle/1000],[0 100]);
ylim([0 30])

bar(H);
a = H';
