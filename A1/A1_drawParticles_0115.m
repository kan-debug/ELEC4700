% Q1p3
% assign position arrays
kb = 1.3806504e-23;               % Boltzmann constant
T = 300;                          % temperature, in Kalvin
me = 0.26*9.10938215e-31;         % electron mass
VThermal = kb*T/me;               % thermal velocity

dt = 0.2e-12;
TStop = 1000 * dt;
TTest = 2;
nParticles = 10;
% trace initialization
TraceParticlesX = zeros(TStop/dt,nParticles);
TraceParticlesY = zeros(TStop/dt,nParticles);
% assigning initial positions
PositionParticlesX = randn([1,nParticles]);
PositionParticlesY = randn([1,nParticles]);
%add this to update function later
TraceParticlesX(1,:) = PositionParticlesX;
TraceParticlesY(1,:) = PositionParticlesY;

% assigning initial velocity
AngleParticle = 360*rand([1,nParticles]);
VelocityParticleX = VThermal*cos(AngleParticle);
VelocityParticleY = VThermal*sin(AngleParticle);
% update trace, delete motiplier later on
TraceParticlesX(2,:) = PositionParticlesX + VelocityParticleX*1000*dt;
TraceParticlesY(2,:) = PositionParticlesY + VelocityParticleY*1000*dt;

% plot(TraceParticlesX(1:2,2),TraceParticlesY(1:2,2));
for R = 1:nParticles
    plot(TraceParticlesX(1:TTest,R),TraceParticlesY(1:TTest,R));
    hold on;
end
grid on