function [accelorationX,accelorationY] = fieldGen(stepsizeX,stepsizeY, sigma,size_box_x,size_box_y)
close all

me = 0.26*9.10938215e-31;         % electron mass
q = -1.602e-19;                    % electron charge 
%initialize matrix
% comments 
%analytical takes longer time numerical takes more memory
% analytical approach the solution by iterating over n in the Tayler
% series, errors from iteration
% numerical solution gets error from step size

V0 = 1;
%the coordinate value
xRange = 51;
yRange = 41;
%sweep parameter, useful?
x_sweep = 1:stepsizeX:xRange;
y_sweep = 1:stepsizeY:yRange;
%sweep elements
el_x = numel(x_sweep);
el_y = numel(y_sweep);

G = sparse(el_x*el_y);
B = zeros(1,el_x*el_y);
rMap = ones(el_y,el_x);
resistance1 = 1/sigma;
halfW=int8(size_box_x/2);
%need change resolution
rMap = dropBox(rMap, xRange, yRange, resistance1, [int8(xRange/2)-halfW,int8(xRange/2)+halfW], [0,size_box_y],stepsizeX,stepsizeY);
rMap = dropBox(rMap, xRange, yRange, resistance1, [int8(xRange/2)-halfW,int8(xRange/2)+halfW], [yRange-size_box_y,yRange],stepsizeX,stepsizeY);
sigmaMap=1./rMap;

figure(1)
ax1 = subplot(2,1,1);
ax2 = subplot(2,1,2);
surf(ax1,sigmaMap)
title(ax1,'conduction map')
xlabel(ax1,'x axis')
ylabel(ax1,'y axis')
view(ax1,2)

%loop across iteration

for i = 1:el_x
    for j = 1:el_y
        n = j + (i - 1) * el_y;
        if i == 1
            % left define V(G(n))=B(n)
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = V0;
        elseif i == el_x
            % right
            G(n, :) = 0;
            G(n, n) = 1;
            B(n) = 0;
        elseif j == 1
            % bottom except for two sides
            % avoid index over boundary
            nxm = j + (i-2)*el_y;
            nxp = j + (i)*el_y;
            nyp = j+1 + (i-1)*el_y;
            
            %dimension modified, j as y in this loop, but j is x in the
            %ramp
            rxm = (sigmaMap(j,i) + sigmaMap(j,i-1))/2.0;
            rxp = (sigmaMap(j,i) + sigmaMap(j,i+1))/2.0;
            ryp = (sigmaMap(j,i) + sigmaMap(j+1,i))/2.0;
            
            G(n,n) = -(rxm+rxp+ryp);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nyp) = ryp;
            
        elseif j ==  el_y
            % top
            nxm = j + (i-2)*el_y;
            nxp = j + (i)*el_y;
            nym = j-1 + (i-1)*el_y;
            
            
            rxm = (sigmaMap(j,i) + sigmaMap(j,i-1))/2.0;
            rxp = (sigmaMap(j,i) + sigmaMap(j,i+1))/2.0;
            rym = (sigmaMap(j,i) + sigmaMap(j-1,i))/2.0;
            
            G(n,n) = -(rxm+rxp+rym);
            G(n,nxm) = rxm;
            G(n,nxp) = rxp;
            G(n,nym) = rym;
        else
            nxm = j + (i-2)*el_y;
            nxp = j + (i)*el_y;
            nym = j-1 + (i-1)*el_y;
            nyp = j+1 + (i-1)*el_y;
            
            
            rxm = (sigmaMap(j,i) + sigmaMap(j,i-1))/2.0;
            rxp = (sigmaMap(j,i) + sigmaMap(j,i+1))/2.0;
            rym = (sigmaMap(j,i) + sigmaMap(j-1,i))/2.0;
            ryp = (sigmaMap(j,i) + sigmaMap(j+1,i))/2.0;
            
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
Vmatrix = zeros(el_y,el_x);
for i = 1:el_x
    for j = 1:el_y
        n = j + (i - 1) * el_y;
        
        Vmatrix(j, i) = Vvector(n);
    end
end

surf(ax2,Vmatrix);
xlabel('x dimention')
ylabel('y dimention')
title('Voltage map')

JXmatrix = zeros(el_y,el_x);
JYmatrix = zeros(el_y,el_x);
EXmatrix = zeros(el_y,el_x);
EYmatrix = zeros(el_y,el_x);

%note the current from xm yield a positive current
%vise versa
for i = 1:el_x
    for j = 1:el_y
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
            
        elseif i==1 &&j==el_y
            rxp = (rMap(j,i) + rMap(j,i+1))/2.0;
            rym = (rMap(j,i) + rMap(j-1,i))/2.0;
            EXmatrix(j, i) = -(Vmatrix(j, i+1)-Vmatrix(j, i));
            EYmatrix(j, i) = Vmatrix(j-1, i)-Vmatrix(j, i);
            Jxp= (Vmatrix(j, i+1)-Vmatrix(j, i))/rxp;
            Jym= (Vmatrix(j-1, i)-Vmatrix(j, i))/rym;
            JXmatrix(j, i) = -Jxp;
            JYmatrix(j, i) = Jym;
        elseif i==el_x &&j==1
            rxm = (rMap(j,i) + rMap(j,i-1))/2.0;
            ryp = (rMap(j,i) + rMap(j+1,i))/2.0;
            EXmatrix(j, i) = +Vmatrix(j, i-1)-Vmatrix(j, i);
            EYmatrix(j, i) = -(Vmatrix(j+1, i)-Vmatrix(j, i));
            Jxm= (Vmatrix(j, i-1)-Vmatrix(j, i))/rxm;
            Jyp= (Vmatrix(j+1, i)-Vmatrix(j, i))/ryp;
            JXmatrix(j, i) = Jxm;
            JYmatrix(j, i) = -Jyp;
        elseif i==el_x &&j==el_y    
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
        elseif i==el_x
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
        elseif j==el_y
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
figure(3)
quiver(EXmatrix,EYmatrix);
xlabel('x dimention')
ylabel('y dimention')
title('Electrical field Map')
% 
figure(4)
quiver(EXmatrix*q,EYmatrix*q);
xlabel('x dimention')
ylabel('y dimention')
title('Force map')
% 
figure(5)
accelorationX = EXmatrix*q/me;
accelorationY = EYmatrix*q/me;
quiver(accelorationX,accelorationY);
xlabel('x dimention')
ylabel('y dimention')
title('acceloration map')


end
