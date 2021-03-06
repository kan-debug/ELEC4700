clear var;

%initialize matrix
nx = 10;
ny = 9;
iteration =30;
matrixV = zeros(ny,nx);

%boundary condition
matrixV(:,1)=ones(1,ny);
matrixV(:,nx)=ones(1,ny);
matrixV(1,:)=zeros(1,nx);
matrixV(ny,:)=zeros(1,nx);

matrixEx=zeros(ny,nx);
matrixEy=zeros(ny,nx);

ax1 = subplot(2,1,1);
ax2 = subplot(2,1,2);
%loop across iteration
for t=1:iteration
    for i = 2:ny-1
        surf(ax1,matrixV);
            title(ax1,'Voltage matrix');
            xlabel(ax1,'X axis');
            ylabel(ax1,'Y axis');
            pause(0.001);
        quiver(ax2,matrixEx,matrixEy);
        title(ax2,'electrical field matrix');
            xlabel(ax2,'X axis');
            ylabel(ax2,'Y axis');
        for j = 2:nx-1
            
            
            
            %note i is y and j is x
%             if i==1
%                 %bottom boundary
%                 matrixV(i,j)=matrixV(i+1,j);
%             elseif i==ny
%                 %top boundary
%                 matrixV(i,j)=matrixV(i-1,j);
                
            
            matrixV(i,j)=(matrixV(i+1,j)+matrixV(i-1,j)+matrixV(i,j+1)+matrixV(i,j-1))/4;
            matrixEx(i,j)= (matrixV(i,j+1)-matrixV(i,j-1))/2;
            matrixEy(i,j)= (matrixV(i+1,j)-matrixV(i-1,j))/2;
            
            
        end
    end
end