clearvars
close all

R1 = 1;
C = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
alpha = 100;
R4 = 0.1;
Ro = 1000;
Vin = 0;
%define Vin

G = zeros(5);
C_MATRIX = zeros(5);
%unknown V = [N1 N2 N5 IL I3]
G =     [1/R1 -1/R1-1/R2 0 1 0;
        1 0 0 0 0;
        0 0 -1/R4-1/Ro 0 alpha/R4;
        0 1 0 0 -R3;
        0 0 0 -1 -1]
    
C_MATRIX =  [C -C 0 0 0;
    0 0 0 0 0;
    0 0 0 0 0;
    0 0 0 L 0;
    0 0 0 0 0]
    
F = [0;Vin;0;0;0];

DC_sweep = -10:10;
DC_sweep_Vo = zeros (1, numel(DC_sweep));
DC_sweep_V3 = zeros (1, numel(DC_sweep));
counter = 1;

for Vin = DC_sweep
F = [0;Vin;0;0;0];
V = G\F;
DC_sweep_Vo(counter) = V(3);
DC_sweep_V3(counter) = V(5)*R3;
counter = counter +1;
end
figure(1)
plot(DC_sweep,DC_sweep_Vo)
hold on
plot(DC_sweep,DC_sweep_V3)
hold off

w = 0:10:100;
AC_sweep_Vo = zeros (1, numel(w));
AC_sweep_gain = zeros (1, numel(w));
counter = 1;
%VIN?
for freq = w
V = (G+1j*freq.*C_MATRIX)\F;
AC_sweep_Vo(counter) = V(3);
AC_sweep_gain(counter) = 10*log(V(3)/Vin);
counter = counter +1;
end
figure(2)
plot(w,AC_sweep_Vo)
hold on
plot(w,AC_sweep_gain)
hold off

figure(3)
C_vector = 0.05.*randn(1,10000);
histogram(C_vector)
C_sweep_gain = zeros(1, numel(C_vector));

for i = 1:numel(C_vector)

C_MATRIX(1,:) =  [C_vector(i) -C_vector(i) 0 0 0];
V = (G+1j*pi.*C_MATRIX)\F;
C_sweep_gain(i) = 10*log(V(3)/Vin);
end
figure(4)
histogram(abs(C_sweep_gain))

