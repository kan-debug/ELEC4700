function [Vin,dt] = SineSignal_inputGen(f)
dt = 1/1000;
t = 0:dt:1-dt;
Vin = sin(2*pi*f*t);
end
