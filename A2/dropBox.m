function [rmap] = dropBox(rmap, nx, ny, resistance, xlim, ylim)
%need check box over boundary

for i=1:nx
    for j=1:ny
        if(i>xlim(1)&&i<xlim(2)&&j>ylim(1)&&j<ylim(2))
            rmap(j,i)=resistance;
        end
    end
end

end