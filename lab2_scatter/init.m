    clear all
    
    clearvars
    clearvars -GLOBAL
    close all
    
    % set(0,'DefaultFigureWindowStyle','docked')
    global C


    C.q_0 = 1.60217653e-19;             % electron charge
    C.hb = 1.054571596e-34;             % Dirac constant
    C.h = C.hb * 2 * pi;                    % Planck constant
    C.m_0 = 9.10938215e-31;             % electron mass
    C.kb = 1.3806504e-23;               % Boltzmann constant
    C.eps_0 = 8.854187817e-12;          % vacuum permittivity
    C.mu_0 = 1.2566370614e-6;           % vacuum permeability
    C.c = 299792458;                    % speed of light
    C.g = 9.80665; %metres (32.1740 ft) per s²

    dt = 15e-15;
    interval = 1000;
    TStop = 1000 * dt;
    nParticles = 5;
    
    % trace initialization
    TraceParticlesX = zeros(TStop/dt,nParticles);
    TraceParticlesY = zeros(TStop/dt,nParticles);
    % assigning initial positions
%     PositionParticlesX = 200e-9*rand([1,nParticles]);
%     PositionParticlesY = 100e-9*rand([1,nParticles]);
    PositionParticlesX = 0;
    PositionParticlesY = 0;
    %add this to update function later
    TraceParticlesX(1,:) = PositionParticlesX;
    TraceParticlesY(1,:) = PositionParticlesY;

    % assigning initial velocity
%     AngleParticle = 360*rand([1,nParticles]);
%     VelocityParticleX = VThermal*cos(AngleParticle);
%     VelocityParticleY = VThermal*sin(AngleParticle);
    VelocityParticleX=zeros(TStop/dt,nParticles);
    VelocityParticleY=zeros(TStop/dt,nParticles);
    
    
    
    % assigning initial force=Eq=ma
    ForceParticleX=1*C.q_0;
    ForceParticleY=0;
    




