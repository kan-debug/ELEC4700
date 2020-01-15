% Q1p3
% assign position arrays
close all
clearvars
kb = 1.3806504e-23;               % Boltzmann constant
T = 300;                          % temperature, in Kalvin
me = 0.26*9.10938215e-31;         % electron mass
VThermal = sqrt(kb*T/me);               % thermal velocity

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
% update trace, delete motiplier later on
[TraceParticlesX,TraceParticlesY] = traceGen.iterate(i,TraceParticlesX,TraceParticlesY,VelocityParticleX,VelocityParticleY,dt);


% plot(TraceParticlesX(1:2,2),TraceParticlesY(1:2,2));
for R = 1:nParticles
    plot(TraceParticlesX(1:TTest,R),TraceParticlesY(1:TTest,R));
    hold on;
end
xlim([0,300]*1e-9)
ylim([0,200]*1e-9)
grid on