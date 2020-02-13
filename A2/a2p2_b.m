clearvars
close all

sigma=0.01;
size_bn_x =14;
size_bn_y =14;
%steps
nx = 1;
ny=1;

%units?

%sweep mesh size
mesh_sweep = 1:10;
counter = 0;
mesh_sweep_current = zeros(2,numel(mesh_sweep));
for i=mesh_sweep
counter = counter +1;
[mesh_sweep_current(1,counter),mesh_sweep_current(2,counter)] = get_current(mesh_sweep(counter),mesh_sweep(counter), sigma,size_bn_x,size_bn_y);
pause(0.01)
end 

%sweep box size
size_sweep = 5:40;
counter = 0;
size_sweep_current = zeros(2,numel(size_sweep));
for i=size_sweep
counter = counter +1;
[size_sweep_current(1,counter),size_sweep_current(2,counter)] = get_current(1,1, sigma,size_sweep(counter),size_sweep(counter));
pause(0.01)
end 

%sweep sigma
sigma_sweep = 10.^(-3:1:3);
counter = 0;
sigma_sweep_current = zeros(2,numel(sigma_sweep));
for i=sigma_sweep
counter = counter +1;
[sigma_sweep_current(1,counter),sigma_sweep_current(2,counter)] = get_current(1,1, sigma_sweep(counter),size_bn_x,size_bn_y);
pause(0.01)
end 
close all
figure(4)
subplot(3,1,1),plot(mesh_sweep,mesh_sweep_current(1,mesh_sweep));
title('current versus mesh size')
xlabel('mesh size')
ylabel('current')
subplot(3,1,2),plot(size_sweep,size_sweep_current(1,1:numel(size_sweep)));
title('current versus box size')
xlabel('box size')
ylabel('current')
subplot(3,1,3),plot(sigma_sweep,sigma_sweep_current(1,1:numel(sigma_sweep)));
title('current versus sigma')
xlabel('box size')
ylabel('current')
set(gca, 'XScale', 'log')


