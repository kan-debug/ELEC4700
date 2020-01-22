classdef traceGen
    methods(Static)
          
        %to reduce the horizontal trace, move the previous point towards
        %different boundary
        %logic indexing
          function [traceXNew,traceYNew] = iterate(interval,traceX,traceY, Vx, Vy, dt)
              % assign initial values
              traceXNew = traceX;
              traceYNew = traceY;
              for i=1:interval
                  
                  %check whether the partical is hitting boundary
                  Xnext = traceXNew(i,:)+(Vx*dt);
                  %VxNew = traceGen.bounceCheck(Xnext,0,200e-9).*VxNew;
                  checkX = traceGen.bounceCheck(Xnext,0,200e-9);
                  Ynext = traceYNew(i,:)+(Vy*dt);
                  %VyNew = traceGen.bounceCheck(Ynext,0,100e-9).*VyNew;
                  checkY = traceGen.bounceCheck(Ynext,0,100e-9);
                  
                  testX = traceXNew(i,:);
          
                  %traceXNew(i+1,:) = traceXNew(i,:)+Vx*dt;
                  [traceXNew(i,:), traceXNew(i+1,:), Vx ]= traceGen.stepNext(checkX,traceXNew(i,:),Vx, dt,1);
                  testXnext = traceXNew(i+1,:);
                  %traceYNew(i+1,:) = traceYNew(i,:)+VyNew*dt;
                  [traceYNew(i,:),traceYNew(i+1,:), Vy ]= traceGen.stepNext(checkY,traceYNew(i,:),Vy, dt,0);
                  
                  
                  
%                   plot(traceXNew(i:i+1,:),traceYNew(i:i+1,:));
%                   %remove hold on to see bug in water
%                   hold on;
%                   pause(0.01);
                  
                  [~,numParticle] = size(traceXNew);
                  color=[1,1,1];
                  for n=1:numParticle
                    plot(traceXNew(i:i+1,n),traceYNew(i:i+1,n),'color',color);
                    %remove hold on to see bug in water
                    hold on;
                    pause(0.001);
                    color=color-[0.09,.09,0];
                  end
                  
                  title(['Temperature is ',num2str(i),' K'])
              end
          
          end
          
          function checkArray = bounceCheck(pos,limLow,limHigh)
              %mode defines behavior for x,y,etc. 
              tempCheck = zeros(1,numel(pos)) + 1;
              for i=1:numel(pos)
                  element = pos(i);
                  if element<=limLow||element>=limHigh
                      tempCheck(1,i)=-1;
                  end
              end
              checkArray = tempCheck;
              %checkArray is one if particle inside boundary, -1 if across
              %boundary
          end
          
          function [Pos, nextPos, nextVel] = stepNext(checkArray, position, Velocity, dt, mode)
              %mode defines the behavior of the collision
              Pos = position;
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
                      
                      for i=1:numel(nextPos)
                          if nextPos(i)>boundary2 
                              nextPos(i)=nextPos(i)-boundary2;
                              Pos(i)=nextPos(i)-nextVel(i)*dt;
                          end
                          if nextPos(i)<boundary1
                              nextPos(i)=nextPos(i)+boundary2;
                              Pos(i)=nextPos(i)-nextVel(i)*dt;
                          end
                      end
                      
                  otherwise
                      fprintf('matlab NMSL, %d',mode)
              end
              
          end
    end
end