function [currentX,currentY] = get_current(nx,ny, sigma,size_box_x,size_box_y)


close all
%initialize matrix
% comments 
%analytical takes longer time numerical takes more memory
% analytical approach the solution by iterating over n in the Tayler
% series, errors from iteration
% numerical solution gets error from step size

V0 = 1;

G = sparse(nx*ny);
B = zeros(1,nx*ny);
rMap = ones(ny,nx);
resistance1 = 1/sigma;
halfW=int8(size_box_x/2);
rMap = dropBox(rMap, nx, ny, resistance1, [int8(nx/2)-halfW,int8(nx/2)+halfW], [0,size_box_y]);
rMap = dropBox(rMap, nx, ny, resistance1, [int8(nx/2)-halfW,int8(nx/2)+halfW], [ny-size_box_y,ny]);
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
        % why resistance in each nodes instead of in between them
        
        
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
title('Voltage map')

JXmatrix = zeros(ny,nx);
JYmatrix = zeros(ny,nx);
EXmatrix = zeros(ny,nx);
EYmatrix = zeros(ny,nx);

%note the current from xm yield a positive current
%vise versa
for i = 1:nx
    for j = 1:ny
        if i==1 &&j==1
            %corners
            rxp = (rMap(j,i) + rMap(j,i+1))/2.0;
            ryp = (rMap(j,i) + rMap(j+1,i))/2.0;
            EXmatrix(j, i) = -(Vmatrix(j, i+1)-Vmatrix(j, i));
            EYmatrix(j, i) = -(Vmatrix(j+1, i)-Vmatrix(j, i));
            Jxp= (Vmatrix(j, i+1)-Vmatrix(j, i))/rxp;
            Jyp= (Vmatrix(j+1, i)-Vmatrix(j, i))/ryp;
            JXmatrix(j, i) = -Jxp;
            JYmatrix(j, i) = -Jyp;
            
        elseif i==1 &&j==ny
            rxp = (rMap(j,i) + rMap(j,i+1))/2.0;
            rym = (rMap(j,i) + rMap(j-1,i))/2.0;
            EXmatrix(j, i) = -(Vmatrix(j, i+1)-Vmatrix(j, i));
            EYmatrix(j, i) = Vmatrix(j-1, i)-Vmatrix(j, i);
            Jxp= (Vmatrix(j, i+1)-Vmatrix(j, i))/rxp;
            Jym= (Vmatrix(j-1, i)-Vmatrix(j, i))/rym;
            JXmatrix(j, i) = -Jxp;
            JYmatrix(j, i) = Jym;
        elseif i==nx &&j==1
            rxm = (rMap(j,i) + rMap(j,i-1))/2.0;
            ryp = (rMap(j,i) + rMap(j+1,i))/2.0;
            EXmatrix(j, i) = +Vmatrix(j, i-1)-Vmatrix(j, i);
            EYmatrix(j, i) = -(Vmatrix(j+1, i)-Vmatrix(j, i));
            Jxm= (Vmatrix(j, i-1)-Vmatrix(j, i))/rxm;
            Jyp= (Vmatrix(j+1, i)-Vmatrix(j, i))/ryp;
            JXmatrix(j, i) = Jxm;
            JYmatrix(j, i) = -Jyp;
        elseif i==nx &&j==ny    
            rxm = (rMap(j,i) + rMap(j,i-1))/2.0;
            rym = (rMap(j,i) + rMap(j-1,i))/2.0;
            EXmatrix(j, i) = +Vmatrix(j, i-1)-Vmatrix(j, i);
            EYmatrix(j, i) = +Vmatrix(j-1, i)-Vmatrix(j, i);
            Jxm= (Vmatrix(j, i-1)-Vmatrix(j, i))/rxm;
            Jym= (Vmatrix(j-1, i)-Vmatrix(j, i))/rym;
            JXmatrix(j, i) = Jxm;
            JYmatrix(j, i) = Jym;
        elseif i==1
            %left
            rxp = (rMap(j,i) + rMap(j,i+1))/2.0;
            rym = (rMap(j,i) + rMap(j-1,i))/2.0;
            ryp = (rMap(j,i) + rMap(j-1,i))/2.0;
            EXmatrix(j, i) = -(Vmatrix(j, i+1)-Vmatrix(j, i));
            EYmatrix(j, i) = -(Vmatrix(j+1, i)-Vmatrix(j, i))+Vmatrix(j-1, i)-Vmatrix(j, i);
            Jxp= (Vmatrix(j, i+1)-Vmatrix(j, i))/rxp;
            Jyp= (Vmatrix(j+1, i)-Vmatrix(j, i))/ryp;
            Jym= (Vmatrix(j-1, i)-Vmatrix(j, i))/rym;
            JXmatrix(j, i) = -Jxp;
            JYmatrix(j, i) = -Jyp+Jym;
        elseif i==nx
            %right
            rxm = (rMap(j,i) + rMap(j,i-1))/2.0;
            rym = (rMap(j,i) + rMap(j-1,i))/2.0;
            ryp = (rMap(j,i) + rMap(j-1,i))/2.0;
            EXmatrix(j, i) = Vmatrix(j, i-1)-Vmatrix(j, i);
            EYmatrix(j, i) = -(Vmatrix(j+1, i)-Vmatrix(j, i))+Vmatrix(j-1, i)-Vmatrix(j, i);
            Jxm= (Vmatrix(j, i-1)-Vmatrix(j, i))/rxm;
            Jyp= (Vmatrix(j+1, i)-Vmatrix(j, i))/ryp;
            Jym= (Vmatrix(j-1, i)-Vmatrix(j, i))/rym;
            JXmatrix(j, i) = Jxm;
            JYmatrix(j, i) = -Jyp+Jym;
        elseif j==1
            %bottom
            rxm = (rMap(j,i) + rMap(j,i-1))/2.0;
            rxp = (rMap(j,i) + rMap(j,i+1))/2.0;
            ryp = (rMap(j,i) + rMap(j+1,i))/2.0;
            EXmatrix(j, i) = -(Vmatrix(j, i+1)-Vmatrix(j, i))+Vmatrix(j, i-1)-Vmatrix(j, i);
            EYmatrix(j, i) = -(Vmatrix(j+1, i)-Vmatrix(j, i));
            Jxp= (Vmatrix(j, i+1)-Vmatrix(j, i))/rxp;
            Jxm= (Vmatrix(j, i-1)-Vmatrix(j, i))/rxm;
            Jyp= (Vmatrix(j+1, i)-Vmatrix(j, i))/ryp;
            JXmatrix(j, i) = -Jxp+Jxm;
            JYmatrix(j, i) = -Jyp;
        elseif j==ny
            %top
            rxm = (rMap(j,i) + rMap(j,i-1))/2.0;
            rxp = (rMap(j,i) + rMap(j,i+1))/2.0;
            rym = (rMap(j,i) + rMap(j-1,i))/2.0;
            EXmatrix(j, i) = -(Vmatrix(j, i+1)-Vmatrix(j, i))+Vmatrix(j, i-1)-Vmatrix(j, i);
            EYmatrix(j, i) = Vmatrix(j-1, i)-Vmatrix(j, i);
            Jxp= (Vmatrix(j, i+1)-Vmatrix(j, i))/rxp;
            Jxm= (Vmatrix(j, i-1)-Vmatrix(j, i))/rxm;
            Jym= (Vmatrix(j-1, i)-Vmatrix(j, i))/rym;
            JXmatrix(j, i) = -Jxp+Jxm;
            JYmatrix(j, i) = Jym;
            
        else
            rxm = (rMap(j,i) + rMap(j,i-1))/2.0;
            rxp = (rMap(j,i) + rMap(j,i+1))/2.0;
            rym = (rMap(j,i) + rMap(j-1,i))/2.0;
            ryp = (rMap(j,i) + rMap(j+1,i))/2.0;
            EXmatrix(j, i) = -(Vmatrix(j, i+1)-Vmatrix(j, i))+Vmatrix(j, i-1)-Vmatrix(j, i);
            EYmatrix(j, i) = -(Vmatrix(j+1, i)-Vmatrix(j, i))+Vmatrix(j-1, i)-Vmatrix(j, i);
            Jxp= (Vmatrix(j, i+1)-Vmatrix(j, i))/rxp;
            Jxm= (Vmatrix(j, i-1)-Vmatrix(j, i))/rxm;
            Jyp= (Vmatrix(j+1, i)-Vmatrix(j, i))/ryp;
            Jym= (Vmatrix(j-1, i)-Vmatrix(j, i))/rym;
            JXmatrix(j, i) = -Jxp+Jxm;
            JYmatrix(j, i) = -Jyp+Jym;
        end
        
    end
end
% 
% figure(3)
% H = quiver(JXmatrix,JYmatrix);
% xlabel('x dimention')
% ylabel('y dimention')
% title('Current Density Map, notice box region')
% 
% figure(4)
% quiver(EXmatrix,EYmatrix);
% xlabel('x dimention')
% ylabel('y dimention')
% title('Electrical field Map')
%current vs mesh-> sum of the current? Unit?
currentX=sum(sum(JXmatrix(:,1:(nx+1)/2)));
currentY=sum(sum(JYmatrix(:,1:(nx+1)/2)));

end