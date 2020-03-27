function [Vin,dt] = StepSignal_inputGen()
dt = 1/1000;
Vin = ones(1,1000);
Npoints = 0.03/dt;
Vin(1:Npoints) = zeros(1,Npoints);
end