classdef scatterFun
    methods(Static)
          
        %to reduce the horizontal trace, move the previous point towards
        %different boundary
          function [traceXNew,traceYNew] = iterate(interval,traceX,traceY, Vx, Vy, dt)
              % assign initial values
              traceXNew = traceX;
              traceYNew = traceY;
              
              timeArray = linspace(0,dt*interval,interval+1);
              %figure init
              
              
              
              for i=1:interval
                  ax1 = subplot(3,1,1);
                  plot(ax1,traceXNew(1:i,1),traceYNew(1:i,1));
                  title(['Velocity is ',num2str(Vx(i,1)),' m/s'])
                  xlabel(ax1,'position x');
                  ylabel(ax1,'position y');
                  
                  ax2=subplot(3,1,2);
                  plot(ax2,timeArray(1:i),traceXNew(1:i,1));
                  xlabel(ax2,'Time');
                  ylabel(ax2,'position X');
                  
                  ax3=subplot(3,1,3);
                  plot(ax3,timeArray(1:i),Vx(1:i,1));
                  xlabel(ax3,'Time');
                  ylabel(ax3,'Velocity X');
                  
                  pause(0.1);
                  


                  [traceXNew(i+1,:), Vx(i+1,1) ]= scatterFun.stepNext([0,0],traceXNew(i,:),Vx(i,1), dt,2);
                  [traceYNew(i+1,:), Vy(i+1,1) ]= scatterFun.stepNext([0,0],traceYNew(i,:),Vy(i,1), dt,3);
                  
              end
              
          
          end
%           
%           function checkArray = bounceCheck(pos,limLow,limHigh)
%               %mode defines behavior for x,y,etc. 
%               tempCheck = zeros(1,numel(pos)) + 1;
%               for i=1:numel(pos)
%                   element = pos(i);
%                   if element<=limLow||element>=limHigh
%                       tempCheck(1,i)=-1;
%                   end
%               end
%               checkArray = tempCheck;
%               %checkArray is one if particle inside boundary, -1 if across
%               %boundary
%           end
%           
          function [nextPos, nextVel] = stepNext(checkArray, position, Velocity, dt, mode)
              %mode defines the behavior of the collision
              switch mode
                  case 0
                      %reflection
                      nextVel = checkArray.*Velocity;
                      nextPos = position + nextVel.*dt;
                  case 1
                      %jump
                      
                      boundary1=0;
                      boundary2=200*1e-9;
                      nextVel = Velocity;
                      nextPos = position + nextVel.*dt;
                      
                      %for each partical across boundary, move to the far
                      %end
                      %Is the graph what he wants? via straight lines?
                      for i=1:numel(nextPos)
                          if nextPos(i)>boundary2 
                              nextPos(i)=nextPos(i)-boundary2;
                          end
                          if nextPos(i)<boundary1
                              nextPos(i)=nextPos(i)+boundary2;
                          end
                      end
                  case 2
                      %acceloration and scatter
                      a_Static=1.60217653e-19/9.10938215e-31;
                      if rand()<=0.05
                          a_actual=-a_Static*0.5;
                          Velocity=0;
                      else
                          a_actual=a_Static;
                      end
                      
                      
                      nextVel = Velocity+a_actual*dt;
                      nextPos = position + nextVel.*dt;
                  case 3
                      %acceloration
                      
                      nextVel = Velocity;
                      nextPos = position + nextVel.*dt;
                  
                  otherwise
                      fprintf('matlab NMSL, %d',mode)
              end
              
              
              
          end
    end
end