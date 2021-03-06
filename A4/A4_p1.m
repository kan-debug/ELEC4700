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
        0 1 0 0 -R3;
        0 0 0 -1 -1]
    
C_MATRIX =  [C -C 0 0 0;
    0 0 0 0 0;
    0 0 0 0 0;
    0 0 0 L 0;
    0 0 0 0 0]
    
F = [0;Vin;0;0;0];

figure(1)
DC_sweep_script
figure(2)
AC_sweep_script

%Cap_sweep_script
figureNum = 3;
[Vin_test,dt] = StepSignal_inputGen;
Vo = transient (Vin_test, dt, G, C_MATRIX, figureNum);
title('Step transition transient')
figure(4)
semilogy(1:1000,abs(fftshift(fft(Vo))))
title('Step transition frequency spectrum')

figureNum = 5;
f = 1/0.03;
[Vin_test,dt] = SineSignal_inputGen(f);
[Vo_sine]=transient (Vin_test, dt, G, C_MATRIX, figureNum);
title('Sine transient')
figure(6)
semilogy(1:1000,abs(fftshift(fft(Vo_sine))))
title('Sine frequency spectrum')

figureNum = 7;
f = 1/0.003;
[Vin_test,dt] = SineSignal_inputGen(f);
[Vo_sine]=transient (Vin_test, dt, G, C_MATRIX, figureNum);
title('Sine high frequency transient')
figure(8)
semilogy(1:1000,abs(fftshift(fft(Vo_sine))))
title('Sine high frequency frequency spectrum')

figureNum = 9;
f = 1/0.3;
[Vin_test,dt] = SineSignal_inputGen(f);
[Vo_sine]=transient (Vin_test, dt, G, C_MATRIX, figureNum);
title('Sine low frequency transient')
figure(10)
semilogy(1:1000,abs(fftshift(fft(Vo_sine))))
title('Sine low frequency frequency spectrum')


figureNum = 11;
[Vin_test] = GaussianSignal_inputGen(dt);
[Vo_sine]=transient (Vin_test, dt, G, C_MATRIX, figureNum);
title('Gaussian transient')
figure(12)
semilogy(1:1000,abs(fftshift(fft(Vo_sine))))
title('Gaussian frequency spectrum')

% change step time
figureNum = 13;
dt = 1/10000;
[Vin_test] = GaussianSignal_inputGen(dt);
[Vo_sine]=transient (Vin_test, dt, G, C_MATRIX, figureNum);
title('Gaussian higher step(10 times) transient')
figure(14)
semilogy(1:10000,abs(fftshift(fft(Vo_sine))))
title('Gaussian higher step(10 times) frequency spectrum')