% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  
close all
clear
% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = linspace(3.305,3.44,10);          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1.0;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125;        % grid size (horizontal)
dy = 0.0125;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute



% First consider the fundamental TE mode:
neff_vector = zeros(1,numel(n2));



for i=1:numel(n2)
    
[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,n2(i),n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy);    
                                        
[Hx_TE,Hy_TE,neff] = wgmodes(lambda,n2(i),nmodes,dx,dy,eps,'000A');
neff_vector(i) = neff;

figure(i);
subplot(121);
contourmode(x,y,Hx_TE(:,:));
title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end

subplot(122);
contourmode(x,y,Hy_TE(:,:));
title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
for v = edges, line(v{:}); end


% Next consider the fundamental TM mode
% (same calculation, but with opposite symmetry)
end

figure(11)
plot(n2,neff_vector)
title('neff plot')