function [  ] = plotTraceFreq( trace,tvec,f,spec,fit_s,treatment)
figure;
subplot(221)
plot(tvec,trace(:,1))
legend({'Baseline'})
ylim([-1 1])

subplot(223)
plot(tvec,trace(:,2),'r')
legend({treatment})
ylim([-1 1])

subplot(222)
plot(f,spec)
legend({'Baseline',treatment})
ylim([-0.2 1]*0.001)

subplot(224)
plot(f,fit_s)
legend({'Baseline',treatment})
ylim([-0.2 1]*0.001)
end