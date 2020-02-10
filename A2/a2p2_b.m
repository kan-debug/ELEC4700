clearvars
close all
nx = 51;
ny = 41;
sigma=0.01;
size_bn_x =5;
size_bn_y =5;

[currentX,currentY] = get_current(nx,ny, sigma,size_bn_x,size_bn_y)