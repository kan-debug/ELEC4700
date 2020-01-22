doPlot = 1;
dt = 15e-15;
TStop = 1000 * dt;
InitDist = 0.05;
Method = 'VE'; % VE -- verlot; FD -- Forward Difference

Mass0 = 14 * C.am; % Silicon
Mass1 = 4 * C.am; % Argon

AtomSpacing = 0.5430710e-9;
LJSigma = AtomSpacing / 2^(1 / 6);
LJEpsilon = 1e-21;

PhiCutoff = 3 * AtomSpacing * 1.1;

T = 30;

AddHCPAtomicBlob(10, 20, 0, 0, 0, 0, InitDist, T, 0);

Ep = 4 * C.q_0;
vx0 = -sqrt(0.02 * Ep / Mass1);
AddCircAtomicArray(3, 20e-9, 0, vx0, 0, 2*InitDist, 0, 1);
AddCircAtomicArray(3, 25e-9, 0, vx0, 0, 2*InitDist, 0, 1);
%AddParticleStream(5, 35, 0, pi / 4, 1, Ep * C.q_0, 0);
%slash
AddParticleStream(5, 35.8, 3.5, pi*5 / 4, 1, Ep, 1);
%handel
AddParticleStream(3, 40.8, 5, 0, 1, Ep, 1);
%wind
AddParticleStream(4, 50, 0, pi, 1, 0.95*Ep, 2);
AddParticleStream(3, 50, 1, pi, 1, 0.95*Ep, 2);
AddParticleStream(5, 50, -1, pi, 1, 0.95*Ep, 2);



Size = 15 * AtomSpacing;
Limits = [-Size +Size -Size +1.5*Size]; % square is good
PlDelt = 5 * dt;
MarkerSize = 4;
PlotFile = 'HCPBlob.gif';
doPlotImage = 1;
PlotSize = [100, 100, 1049, 1549];

ScaleV = .2e-11;
ScaleF = 20;
