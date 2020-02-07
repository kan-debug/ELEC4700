clearvars
close all
%initialize matrix
% comments 
%analytical takes longer time numerical takes more memory
% analytical approach the solution by iterating over n in the Tayler
% series, errors from iteration
% numerical solution gets error from step size
nx = 21;
ny = 21;
iteration =30;
V0 = 1;
matrixV = zeros(ny,nx);

G = sparse(nx*ny);
B = zeros(1,nx*ny);
cMap = ones(nx,ny);

figure(1)
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
            
            rxm = (cMap(i,j) + cMap(i-1,j))/2.0;
            rxp = (cMap(i,j) + cMap(i+1,j))/2.0;
            rym = (cMap(i,j) + cMap(i,j-1))/2.0;
            ryp = (cMap(i,j) + cMap(i,j+1))/2.0;
            
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
Vmatrix = zeros(ny,nx);
for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;
        
        Vmatrix(j, i) = Vvector(n);
    end
end
subplot(2, 1, 1), H = surf(Vmatrix);
xlabel('x dimention')
ylabel('y dimention')

%note the width and length are not nx, ny
Vanalytical = zeros(ny,nx);
for n=1:2:201
    for i = 1:nx
        for j = 1:ny
            
            iNorm = i-1-(nx-1)/2;
            jNorm = j-1;
            
            Vanalytical(j, i)=Vanalytical(j, i)+4*V0/pi*(1/n)*(cosh(n*pi*iNorm/(ny-1))/cosh(n*pi*(nx-1)/(ny-1)/2))*sin(n*pi*jNorm/(ny-1));
            
            
        end
        subplot(2, 1, 2), H = surf(Vanalytical);
        xlabel('x dimention')
        ylabel('y dimention')
    end
    
    
    pause(0.01);
    
    
end
