clearvars
close all
%initialize matrix
% comments 
%analytical takes longer time numerical takes more memory
% analytical approach the solution by iterating over n in the Tayler
% series, errors from iteration
% numerical solution gets error from step size
nx = 51;
ny = 41;
iteration =30;
V0 = 1;
matrixV = zeros(ny,nx);

G = sparse(nx*ny);
B = zeros(1,nx*ny);
rMap = ones(ny,nx);
resistance1 = 100;
rMap = dropBox(rMap, nx, ny, resistance1, [int8(nx/3),int8(2*nx/3)], [0,int8(ny/3)]);
rMap = dropBox(rMap, nx, ny, resistance1, [int8(nx/3),int8(2*nx/3)], [int8(2*ny/3),ny]);
sigmaMap=1./rMap;

figure(1)
surf(sigmaMap)
title('conduction map')
xlabel('x axis')
ylabel('y axis')

%loop across iteration

for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;
        if i == 1
            % left define V(G(n))=B(n)
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = V0;
        elseif i == nx
            % right
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = V0;
        elseif j == 1
            % bottom except for two sides
            % avoid index over boundary
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 0;
            
        elseif j ==  ny
            % top
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 0;
        else
            nxm = j + (i-2)*ny;
            nxp = j + (i)*ny;
            nym = j-1 + (i-1)*ny;
            nyp = j+1 + (i-1)*ny;
            
            %dimension modified, j as y in this loop, but j is x in the
            %ramp
            rxm = (rMap(j,i) + rMap(j,i-1))/2.0;
            rxp = (rMap(j,i) + rMap(j,i+1))/2.0;
            rym = (rMap(j,i) + rMap(j-1,i))/2.0;
            ryp = (rMap(j,i) + rMap(j-1,i))/2.0;
            
            G(n,n) = -(rxm+rxp+rym+ryp);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nym) = rym;
            G(n,nyp) = ryp;
        end
        % not really derivative but actual voltages
        
        
    end
    
end
Vvector = G\B';
%mapping
Vmatrix = zeros(ny,nx);
for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;
        
        Vmatrix(j, i) = Vvector(n);
    end
end
figure(2)
H = surf(Vmatrix);
xlabel('x dimention')
ylabel('y dimention')

Imatrix = zeros(ny,nx);
for i = 1:nx
    for j = 1:ny
        
        Imatrix(j, i) = Vmatrix(j, i);
    end
end

