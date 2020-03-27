clearvars
close all

R1 = 1;
C = 0.25;
R2 = 2;
L = 0.2;
%extracted from the slope
R3 = 1/0.1429;
alpha = 100;
R4 = 0.1;
Ro = 1000;
Vin = 0;
%define Vin
In = 0;
Cp = 0.00001;


%previous unknown V = [N1 N2 N5 IL I3]
%now unknown V = [N1 N2 N3 N5 IL I3]
G =     [1/R1 -1/R1-1/R2 0 0 1 0;       %KCL node N2
        0 0 0 0 -1 -1;                  %KCL node N3
        0 0 0 -1/R4-1/Ro 0 alpha/R4;    %KCL node N5
        0 1 -1 0 0 0;                   %inductor current
        1 0 0 0 0 0;                    %input
        0 0 1 0 0 -R3];                 %I3
    
C_MATRIX =  [C -C 0 0 0 0;
    0 0 -C 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 L 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0];
    
F = [0;In;0;0;Vin;0];

%With In=0, DC (no Cap effect) simulation proved to be the same
%DC_sweep_script


%Cap_sweep_script

In = 0.001*randn(1,1000);
histogram(In)
figureNum = 1;
[Vin_test] = GaussianSignal_inputGen(dt);
[Vo_sine,~]=transient (Vin_test, dt, G, C_MATRIX, figureNum);
figure(8)
plot(1:1000,real(fftshift(fft(Vo_sine))))
