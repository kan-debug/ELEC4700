
DC_sweep = -10:10;
DC_sweep_Vo = zeros (1, numel(DC_sweep));
DC_sweep_V3 = zeros (1, numel(DC_sweep));
counter = 1;
%unknown V = [N1 N2 N5 IL I3]
for Vin = DC_sweep
F = [0;Vin;0;0;0];
V = G\F;
DC_sweep_Vo(counter) = V(3);
DC_sweep_V3(counter) = V(5)*R3;
counter = counter +1;
end
plot(DC_sweep,DC_sweep_Vo)
hold on
plot(DC_sweep,DC_sweep_V3)
hold off
title('DC voltage sweep')
xlabel('Vin (V)')
ylabel('Voltage (V)')
legend('Vout (V)','V3 (V)')
