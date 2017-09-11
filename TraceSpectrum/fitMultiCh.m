function [ fitted_y ] = fitMultiCh( x,data_y,fit_type )
%FITMULTICH Summary of this function goes here
%   Data is the input with data*channel,fit_type = 'power1' or 'poly5', etc
n_ch = size(data_y,2);
fitted_y = zeros(size(data_y));
for i = 1:n_ch
fit_curve = fit(x,data_y(:,i),fit_type);
fitted_y(:,i) = feval(fit_curve,x);
end
end

