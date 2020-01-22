function [ output_args ] = AddParticleStream(num, x0, y0, PartAng, Type, Ep, Seper)
global AtomSpacing x y AtomType Vx Vy Mass0 Mass1 nAtoms
%num is number of atoms, partAngle is angle, Ep kinetic energy?, Seper is
%seperation
if Type == 0
    Mass = Mass0;
else
    Mass = Mass1;
end

for p = 0:num - 1
    nAtoms = nAtoms + 1;
    x(nAtoms) = x0 * AtomSpacing - Seper * p * AtomSpacing * cos(PartAng);
    y(nAtoms) = y0 * AtomSpacing - Seper * p * AtomSpacing * sin(PartAng);
    AtomType(nAtoms) = Type;
end

V = -sqrt(0.02 * Ep / Mass);

for p = 1:num
    Vx(nAtoms - num + p) = V;
    Vy(nAtoms - num + p) = 0;
end

end
