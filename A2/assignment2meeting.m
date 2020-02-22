%% Assignment 2
%% Part1 Question a
% With constant resistance across the material and boundary conditions on left
% and right, the voltage drop should be a straight line (dV/dx is negative constant).

a2p1q1_1D

%% Part1 Question b analytical
% The boundary conditions are two x boundaries fixed to V0(1V in this case), two
% other sides fixed to the ground. Due to constant conductance(sigma), the result is a
% smooth surface.
a2p1q1_analytical
%% Part1 Question b numerical
% The boundary conditions are two sides fixed to V0 (1V) and two sides
% fixed to the ground. The current flow from 1V to 0V, with a 90degree change of
% direction. The curve is smooth because of constant conductance.
%
% The accuracy of the numerical method
% depends on the mesh size. On the other hand, the accuracy of the analytical
% solution depends on the number of the series (N=1,3,5...) included. The more series
% included, the more accurate result can be expected, but due to the
% infinite number of series available, the result is still an
% (close enough) approximation.
%
% Notice for the numeric case the four corners are different from analytical. This
% is because in analytical V(0,0)=0, due to Y boundary condition; in
% numerical V(0,0)=1, due to the X boundary condition. All other points are
% similar if not the same.
a2p1q1_numeric


%% Part2 Question a
% This part changes the material so the sigma is no longer constant. 
% The main idea is the current flow across three parallel resistors! One resistor
% has a sigma of 1 (bottleneck), and the other two box resistors have a sigma of 0.01.
%
% Sigma plot shows a lower conductivity in the box region, as expected.
% Therefore more current will flow across the higher conductivity region
% since the resistors on the sides are shorted.
% 
% The voltage map shows voltage mainly drops across the middle region, via
% highly conductive region. The box regions have almost zero voltage drop,
% since almost no current flow across it (shorted).
%
% The current density and the electrical field plots are almost identical. 
% This is due to ohms law:
%
% $I=V/R$
% 
% $dI/dx = (dV/dx)/(dR/dx)$
% 
% where R is a constant inside box and outside the box, dR/dx is zero; dV/dx is
% the electrical field, dI/dx is the current density
%
% $J = E/R$
%
% where J and E are vectors, R is scalar. Therefore the J matrix and E
% matrix are going to be identical in direction, different in magnitude.
% More specifically, the magnitude is going to be the same as well outside the
% box region, with a resistance equals to 1.
a2p2q1

%% Part2 Question b,c,d
% The current drawing in the graph is the current in the sigma = 1 region. The
% current is NOT constant from left to right:
%
% $sum(Jx(column1)!=sum(Jx(column2))!=sum(Jx(column_Others))$
%
% The main idea of this part is simple. The voltage drop across the whole
% region is constant (1V) while the box region varies. As the box region
% increases resistivity/size, lower voltage is dropped over the box region.
% Therefore more voltage has to be dropped over regions outside of the
% boxes, hence higher current (with constant resistivity outside the boxed region).
%
% To be honest, this is a bit counter-intuitive compared to the resistor
% analogy made before. This is due to the current is not constant across x
% direct, so the current divider does not work!
%
% The increment in mesh size does not highly affect the current, with a size
% smaller than 8. Higher mesh size (lower resolution) makes the box
% effectively larger and bottleneck smaller. Therefore a higher current is
% observed. Similar case for the increased box size, since both
% effectively sweep the size of the box.
%
% Higher sigma means a higher conductivity in the box region, more voltage is
% dropped over the boxed region, less voltage drop over region outside the box,
% less current on the edge is observed!

a2p2_b
