function [Vo, gain] = transient (Vin, dt, G, C_MATRIX)

tStop = 1;
%unknown V = [N1 N2 N5 IL I3]
V = zeros (5, numel(Vin));
Vo = zeros (1, numel(Vin));
gain = zeros (1, numel(Vin));


%dv/dt is difference between current and previous
%refer to ELEC4700 ppt9 page 29
% Algebric dt
% combining effect of C and R
A = C_MATRIX/dt + G;
counter = 1;


for time = 0:dt:tStop
    
    % forcing factors
    F = [0;Vin(counter);0;0;0];
   
    if counter == 1
        %need DC simulation to determin initial guess.. or not?
        V(:,counter) = G\F;
    else
        %refer slides, size question
        V(:,counter) = A\((C_MATRIX/dt)*V(:,counter-1)+F);
    end

Vo(counter) = V(3,counter);
gain(counter) = 10*log(V(3,counter)/Vin(counter));


%move this outside later on
figure(2)
plot(0:dt:time,real(Vo(1:counter)))
hold on
plot(0:dt:time,real(Vin(1:counter)))
plot(0:dt:time,real(gain(1:counter)))
hold off
legend('Vout (V)','Vin (V)', 'gain (log10)')
counter = counter +1;
end

end