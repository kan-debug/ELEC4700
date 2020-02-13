clearvars
close all
%initialize matrix
nx = 20;
ny = 20;
iteration =30;
matrixV = zeros(ny,nx);

G = sparse(nx*ny);
B = zeros(1,nx*ny);
cMap = ones(nx,ny);


%loop across iteration

for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;
        if i == 1
            % left define V(G(n))=B(n)
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 1;
        elseif i == nx
            % right
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 0;
        elseif j == 1
            % bottom except for two sides
            % avoid index over boundary
            nxm = j + (i - 2) * ny;
            nxp = j + (i) * ny;
            nyp = j + 1 + (i - 1) * ny;
            
            %default cMap=1 to be average
            rxm = (cMap(i, j) + cMap(i - 1, j)) / 2.0;
            rxp = (cMap(i, j) + cMap(i + 1, j)) / 2.0;
            ryp = (cMap(i, j) + cMap(i, j + 1)) / 2.0;
            
            G(n, n) = -(rxm+rxp+ryp);
            G(n, nxm) = rxm;
            G(n, nxp) = rxp;
            G(n, nyp) = ryp;
            
        elseif j ==  ny
            % top
            nxm = j + (i - 2) * ny;
            nxp = j + (i) * ny;
            nym = j - 1 + (i - 1) * ny;
            
            rxm = (cMap(i, j) + cMap(i - 1, j)) / 2.0;
            rxp = (cMap(i, j) + cMap(i + 1, j)) / 2.0;
            rym = (cMap(i, j) + cMap(i, j - 1)) / 2.0;
            
            G(n, n) = -(rxm + rxp + rym);
            G(n, nxm) = rxm;
            G(n, nxp) = rxp;
            G(n, nym) = rym;
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
H = surf(Vmatrix');
xlabel('x dimention')
ylabel('y dimention')
zlabel('z dimention')
view(60,-30)
