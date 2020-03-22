function [Vo, gain] = transient (Vin, dt, G, C_MATRIX)

tStop = 1;
V = zeros (5, numel(Vin));
Vo = zeros (1, numel(Vin));
gain = zeros (1, numel(Vin));


%dv/dt is difference between current and previous
%refer to ppt9 page 29
counter = 1;
for time = 0:dt:1
    F = [0;Vin(1);0;0;0];
if counter == 1
    %need DC simulation to determin initial guess.. or not?
    V(:,counter) = G\F;
else
    V = (G+dV.*C_MATRIX)\F;
    dV = 
end

AC_sweep_Vo(counter) = V(3);
AC_sweep_gain(counter) = 10*log(V(3)/Vin);
counter = counter +1;

end
figure(2)
plot(w,real(AC_sweep_Vo))
hold on
plot(w,real(AC_sweep_gain))
hold off
end