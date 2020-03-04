%http://matlab.izmiran.ru/help/techdoc/ref/griddata.html
%http://matlab.izmiran.ru/help/techdoc/ref/meshgrid.html

% assign position arrays
close all
clearvars
kb = 1.3806504e-23;               % Boltzmann constant
T = 300;                          % temperature, in Kalvin
me = 0.26*9.10938215e-31;         % electron mass
q = -1.602e-19;                    % electron charge  
% with two degree of freedom: 2*1/2kT
VThermalMean = sqrt(2*kb*T/me);               % thermal velocity
xVolt = 0.1;                        %potential difference, positive-negative
yVolt = 0;

dt = 15e-15;
i = 100;
TStop = 1000 * dt;

TTest = 1000;
nParticles = 10000;
nParticlesPlot = 1000;
Xlim = 200e-9;
Ylim = 100e-9;

% trace initialization
TraceParticlesX = zeros(TStop/dt,nParticles);
TraceParticlesY = zeros(TStop/dt,nParticles);
% assigning initial positions
% PositionParticlesX = Xlim*rand([1,nParticles]);
% PositionParticlesY = Ylim*rand([1,nParticles]);
[PositionParticlesX, PositionParticlesY] = traceGen_p2.boxInit([50e-9;50e-9], [0;Ylim-40e-9], 50e-9, 40e-9, Xlim, Ylim,nParticles);
%add this to update function later
TraceParticlesX(1,:) = PositionParticlesX;
TraceParticlesY(1,:) = PositionParticlesY;

%assigning acceloration and displaying it
[Ax,Ay] = fieldGen(1,1,0.01,int8(0.5e-7/2e-7*51),int8(0.4e-7/1e-7*41));

% assigning initial velocity
AngleParticle = 360*rand([1,nParticles]);
%1e4 as deviation, thermal velocity as mean
VThermal = VThermalMean+1e4.*randn(1,nParticles);
% figure(1);
% histogram(VThermal);
% title('Distribution of initial velocity');
% xlabel('Velocity (m/s)');
% ylabel('number of particles (1)');
VelocityParticleX = VThermal.*cos(AngleParticle);
VelocityParticleY = VThermal.*sin(AngleParticle);

% update trace, delete motiplier later on
[TraceParticlesX,TraceParticlesY] = traceGen_p2.iterate(i,TraceParticlesX(:,1:nParticlesPlot),TraceParticlesY(:,1:nParticlesPlot),VelocityParticleX(:,1:nParticlesPlot),VelocityParticleY(:,1:nParticlesPlot),dt, Ax, Ay);
