% Q1p3
% assign position arrays
close all
clearvars
kb = 1.3806504e-23;               % Boltzmann constant
T = 300;                          % temperature, in Kalvin
me = 0.26*9.10938215e-31;         % electron mass
% with two degree of freedom: 2*1/2kT
VThermal = sqrt(2*kb*T/me);               % thermal velocity

dt = 15e-15;
i = 1000;
TStop = 1000 * dt;

TTest = 1000;
nParticles = 10;
% trace initialization
TraceParticlesX = zeros(TStop/dt,nParticles);
TraceParticlesY = zeros(TStop/dt,nParticles);
% assigning initial positions
PositionParticlesX = 200e-9*rand([1,nParticles]);
PositionParticlesY = 100e-9*rand([1,nParticles]);
%add this to update function later
TraceParticlesX(1,:) = PositionParticlesX;
TraceParticlesY(1,:) = PositionParticlesY;

% assigning initial velocity
AngleParticle = 360*rand([1,nParticles]);
VelocityParticleX = VThermal*cos(AngleParticle);
VelocityParticleY = VThermal*sin(AngleParticle);
mean(VelocityParticleX)
mean(VelocityParticleY)
velAvg = sqrt(mean(VelocityParticleX.^2)+mean(VelocityParticleY.^2));
refT=0.5*me*velAvg^2/kb;

testTemp = traceGen.getTemp(VelocityParticleX,VelocityParticleY);
% update trace, delete motiplier later on
[TraceParticlesX,TraceParticlesY] = traceGen.iterate(i,TraceParticlesX,TraceParticlesY,VelocityParticleX,VelocityParticleY,dt);


% 
% for R = 1:nParticles
%     plot(TraceParticlesX(1:TTest,R),TraceParticlesY(1:TTest,R));
%     pause(0.1);
%     hold on;
% end

xlim([0,300]*1e-9)
ylim([0,200]*1e-9)
grid on