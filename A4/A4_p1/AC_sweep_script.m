w = 0:10:100;
AC_sweep_Vo = zeros (1, numel(w));
AC_sweep_gain = zeros (1, numel(w));
counter = 1;
%VIN?
for freq = w
V = (G+1j*freq.*C_MATRIX)\F;
AC_sweep_Vo(counter) = V(3);
AC_sweep_gain(counter) = 10*log(V(3)/Vin);
counter = counter +1;
end
figure(2)
plot(w,real(AC_sweep_Vo))
hold on
plot(w,real(AC_sweep_gain))
hold off