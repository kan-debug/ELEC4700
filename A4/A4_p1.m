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

G = zeros(5);
C_MATRIX = zeros(5);
%unknown V = [N1 N2 N5 IL I3]
G =     [1/R1 -1/R1-1/R2 0 1 0;
        1 0 0 0 0;
        0 0 -1/R4-1/Ro 0 alpha/R4;
        0 -1 0 0 R3;
        0 0 0 -1 -1]
    
C_MATRIX =  [C -C 0 0 0;
    0 0 0 0 0;
    0 0 0 0 0;
    0 0 0 L 0;
    0 0 0 0 0]
    
F = [0;Vin;0;0;0];

DC_sweep_script

AC_sweep_script

Cap_sweep_script

transient


