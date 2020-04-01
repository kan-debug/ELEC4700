function [Vin] = GaussianSignal_inputGen(dt)
t = 0:dt:1-dt;

variance = 0.03;
mean = 0.06;
% the coefficient determines the magnitude
% Vin = (1/(variance*sqrt(2*pi))*exp(-1/2*(t-mean).^2));
Vin = exp(-1/2*((t-mean)/variance).^2);
% plot(t,Vin)
end