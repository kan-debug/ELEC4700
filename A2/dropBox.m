function [rmap] = dropBox(rmap, nx, ny, resistance, xlim, ylim,stepsizeX,stepsizeY)
%need check box over boundary
if ~exist('stepsizeX','var')||~exist('stepsizeX','var')
     % last parameter does not exist, so default it to something
      stepsizeX = 1;
      stepsizeY = 1;
end
 
x_sweep = 1:stepsizeX:nx;
y_sweep = 1:stepsizeY:ny;
counterX = 0;

for i=x_sweep
    counterX = counterX+1;
    counterY = 0;
    for j=y_sweep
        counterY = counterY+1;
        if(i>xlim(1)&&i<xlim(2)&&j>ylim(1)&&j<ylim(2))
            rmap(counterY,counterX)=resistance;
        end
    end
end

end