clearvars
%initialize matrix
nx = 20;
matrixV = zeros(nx);

G = sparse(nx);
B = zeros(1,nx);
cMap = ones(nx);
%loop across iteration

for i = 1:nx
        n = i;
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
        
        else
            nxm = i-1;
            nxp = i+1;
            
            G(n,n) = -2;
            G(n,nxm) = 1;
            G(n,nxp) = 1;
        end
        % not really derivative but actual voltages

end
Vvector = G\B';

figure(1)
H = plot(Vvector);
grid on
xlim([1 nx])
title('1-D plot of V(x)')
xlabel('x')
ylabel('Voltage (V)')

