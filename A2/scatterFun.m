classdef scatterFun
    methods(Static)
          
        %to reduce the horizontal trace, move the previous point towards
        %different boundary
          function [traceXNew,traceYNew] = iterate(interval,traceX,traceY, Vx, Vy, dt)
              % assign initial values
              traceXNew = traceX;
              traceYNew = traceY;
              for i=1:interval
                  plot(traceXNew(1:i,1),traceYNew(1:i,1));
                  pause(0.1);
                  


                  [traceXNew(i+1,:), Vx ]= scatterFun.stepNext([0,0],traceXNew(i,:),Vx, dt,2);
                  [traceYNew(i+1,:), Vy ]= scatterFun.stepNext([0,0],traceYNew(i,:),Vy, dt,3);
                  
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
                      %acceloration
                      a=1.60217653e-19/9.10938215e-31;
                      nextVel = Velocity+a*dt;
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