%30*20 grid
clearvars
nx = 30;
ny = 20;
V=zeros(nx,ny);
iteration = 75;

for n = 1:2:iteration
    for i = 1:nx
        for j = 1:ny 
            %mapping to remove errors
            i_n = (i-1)-(nx-1)/2;
            j_n = (j-1);
            V(i,j) = V(i,j)+((4/pi)*(1/n)*(cosh((n*pi*i_n)/(ny-1)))/(cosh((n*pi*((nx-1)/2))/(ny-1)))*sin((n*pi*(j_n))/(ny-1)));           
        end
    end
    figure(2)
    surf(V);
    xlabel('X');
    ylabel('Y');
    zlabel('Voltage');
    title('analytical solution for bounded voltage');
    pause(0.01);
    grid on;
end

