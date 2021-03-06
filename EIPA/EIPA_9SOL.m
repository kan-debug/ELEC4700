clearvars
close all
%initialize matrix
nx = 50;
ny = 50;
iteration =30;
matrixV = zeros(ny,nx);

G = sparse(nx*ny);
B = zeros(1,nx*ny);
cMap = ones(nx,ny);


%loop across iteration

for i = 1:nx
    for j = 1:ny
        nxm = j + (i-2)*ny;
        nxp = j + (i)*ny;
        nym = j-1 + (i-1)*ny;
        nyp = j+1 + (i-1)*ny;
        n = j + (i - 1) * ny;
        if i == 1 || i == nx || j == 1 || j ==  ny
            % left define V(G(n))=B(n)
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 0;
        elseif i>10&&i<20&&j>10&&j<20
            rxm = (cMap(i,j) + cMap(i-1,j))/2.0;
            rxp = (cMap(i,j) + cMap(i+1,j))/2.0;
            rym = (cMap(i,j) + cMap(i,j-1))/2.0;
            ryp = (cMap(i,j) + cMap(i,j+1))/2.0;
            
            G(n,n) = -(rxm+rxp+rym+ryp)/2;
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nym) = rym;
            G(n,nyp) = ryp;
        else
            
            
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
figure(1)
spy(G)
figure(2)
[E,D] = eigs(G,9,'SM');
plot(D)
figure(3)

Vmatrix = zeros(ny,nx);
for eig = 1:9
    for i = 1:nx
        for j = 1:ny
            n = j + (i - 1) * ny;
            Vmatrix(j, i) = E(n,eig);
        end
    end
    
    subplot(3, 3, eig), surf(Vmatrix');
    pause(0.01)
end


