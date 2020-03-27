
figure(3)
C_vector = 0.05.*randn(1,10000);
histogram(C_vector)
C_sweep_gain = zeros(1, numel(C_vector));

for i = 1:numel(C_vector)

C_MATRIX(1,:) =  [C_vector(i) -C_vector(i) 0 0 0];
V = (G+1j*pi.*C_MATRIX)\F;
C_sweep_gain(i) = 10*log(V(3)/Vin);
end
figure(4)
histogram(abs(C_sweep_gain))
