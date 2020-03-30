function [Vo, gain] = transient_p2 (Vin, dt, G, C_MATRIX, figureNum,In)

tStop = 1;
%unknown V = [N1 N2 N5 IL I3]
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
    else
        %refer slides, size question
        V(:,counter) = A\((C_MATRIX/dt)*V(:,counter-1)+F);
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