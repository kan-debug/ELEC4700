clearvars
%initialize matrix
nx = 20;
ny = 20;
matrixV = zeros(ny,nx);

G = sparse(nx*ny);
B = zeros(1,nx*ny);
cMap = ones(nx,ny);


%loop across iteration

for i = 1:nx
    for j = 1:ny
        n = j + (i - 1) * ny;
        if i == 1 || i == nx
            
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 1;
        elseif j == 1 || j == nx
            
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
figure(3)
H = surf(Vmatrix');
xlabel('x dimention')
ylabel('y dimention')
zlabel('z dimention')

