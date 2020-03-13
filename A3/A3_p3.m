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

box1 = zeros(1,4);
box2 = zeros(1,4);

% trace initialization
TraceParticlesX = zeros(TStop/dt,nParticles);
TraceParticlesY = zeros(TStop/dt,nParticles);
% assigning initial positions
% PositionParticlesX = Xlim*rand([1,nParticles]);
% PositionParticlesY = Ylim*rand([1,nParticles]);
[PositionParticlesX, PositionParticlesY] = traceGen_p3.boxInit([75e-9;125e-9], [0;Ylim-40e-9], 50e-9, 40e-9, Xlim, Ylim,nParticles);
%add this to update function later
TraceParticlesX(1,:) = PositionParticlesX;
TraceParticlesY(1,:) = PositionParticlesY;

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

% sweep box size
size_sweep = 0.05:0.05:0.25;
counter = 0;
size_sweep_current = zeros(1,numel(size_sweep));
% row->sweeps column->each particle
densityX = zeros(numel(size_sweep),nParticlesPlot);
densityY = zeros(numel(size_sweep),nParticlesPlot);



for j=size_sweep

counter = counter +1;

box1 = [1-size_sweep(counter),0,1+size_sweep(counter),0+2*size_sweep(counter)]*1e-7;
box2 = [box1(1),(1-2*size_sweep(counter))*1e-7,box1(3),1*1e-7];
box_width = size_sweep(counter)*2e-7;
box_height = size_sweep(counter)*2e-7;
%acceloration
[Ax,Ay] = fieldGen(1,1,0.01,int8(box_width/2e-7*51),int8(box_height/1e-7*41));

[size_sweep_current(counter),densityX(counter,:),densityY(counter,:)] = traceGen_p3.iterate(i,TraceParticlesX(:,1:nParticlesPlot),TraceParticlesY(:,1:nParticlesPlot),VelocityParticleX(:,1:nParticlesPlot),VelocityParticleY(:,1:nParticlesPlot),dt, Ax, Ay, box1, box2);
end 

close all
figure(1)
plot(size_sweep*1e-7,abs(size_sweep_current(1:numel(size_sweep))))
title('current density versus box size')
xlabel('box size')
ylabel('current density')

%density maps
for m = 1:numel(size_sweep)
    figure(m+1)
    hist3([densityX(m,:).',densityY(m,:).'],[20,10])
    set(gcf,'renderer','opengl');
    set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
    title(['Particle density at the end with box size ',num2str(size_sweep(m)*1e-7),' m']);
    view(20,45)
    
end
