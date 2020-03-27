
DC_sweep = -10:10;
DC_sweep_Vo = zeros (1, numel(DC_sweep));
DC_sweep_V3 = zeros (1, numel(DC_sweep));
counter = 1;

%now unknown V = [N1 N2 N3 N5 IL I3]

for Vin = DC_sweep
F = [0;In;0;0;Vin;0];
V = G\F;
DC_sweep_Vo(counter) = V(4);
DC_sweep_V3(counter) = V(3);
counter = counter +1;
end
figure(1)
plot(DC_sweep,DC_sweep_Vo)
hold on
plot(DC_sweep,DC_sweep_V3)
hold off
title('DC voltage sweep')
xlabel('Vin (V)')
ylabel('Vo (V)')
