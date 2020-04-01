function [Vo, gain] = transient_nonLinear (Vin, dt, G, C_MATRIX, figureNum,In)
alpha = 100;
beta =100;
gamma=100;
R4 = 0.1;
Ro = 1000;

tStop = 1;
%now unknown V = [N1 N2 N3 N5 IL I3]
V = zeros (6, numel(Vin));
Vo = zeros (1, numel(Vin));
gain = zeros (1, numel(Vin));
test = zeros (1, numel(Vin));
%dv/dt is difference between current and previous
%refer to ELEC4700 ppt9 page 29
% Algebric dt
% combining effect of C and R
A = C_MATRIX/dt + G;
counter = 1;

%total point is one more since including 0
for time = 0:dt:tStop-dt
   
    % forcing factors
    F = [0;In(counter);0;0;Vin(counter);0];
   
    if counter == 1
        %need DC simulation to determin initial guess.. or not?
        V(:,counter) = G\F;
        %iterate b
        V(:,counter)
        I3 = V(6,counter);
        %now unknown V = [N1 N2 N3 N5 IL I3], force V5
        B = [0; 0; (alpha*I3+beta*I3^2+gamma*I3^3)*Ro/(R4+Ro); 0; 0; 0];
        V(:,counter) = G\(F+B);
    else
        %refer slides, size question
        V(:,counter) = A\((C_MATRIX/dt)*V(:,counter-1)+F);
        V(:,counter)
        I3 = V(6,counter);
        B = [0; 0; (alpha*I3+beta*I3^2+gamma*I3^3)*Ro/(R4+Ro); 0; 0; 0];
        V(:,counter) = A\((C_MATRIX/dt)*V(:,counter-1)+F+B);
    end
%now unknown V = [N1 N2 N3 N5 IL I3]
Vo(counter) = V(4,counter);
test(counter) = In(counter);
counter = counter +1;
end
figure(figureNum)
plot(0:dt:tStop-dt,real(Vo))
hold on
plot(0:dt:tStop-dt,real(Vin))
plot(0:dt:tStop-dt,test)
hold off
legend('Vout (V)','Vin (V)','In(A)')
end