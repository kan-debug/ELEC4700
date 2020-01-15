classdef traceGen
    methods(Static)
          
          function [traceXNew,traceYNew] = iterate(interval,traceX,traceY, Vx, Vy, dt)
              % assign initial values
              traceXNew = traceX;
              traceYNew = traceY;
              VxNew = Vx;
              VyNew = Vy;
              for i=1:interval
                  
                  Xnext = traceXNew(i,:)+(VxNew*dt);
                  VxNew = traceGen.bounceCheck(Xnext,0,200e-9).*VxNew;
                  Ynext = traceYNew(i,:)+(VyNew*dt);
                  VyNew = traceGen.bounceCheck(Ynext,0,100e-9).*VyNew;
                  testX = traceXNew(i,:);
          
                  traceXNew(i+1,:) = traceXNew(i,:)+VxNew*dt;
                  testXnext = traceXNew(i+1,:);
                  traceYNew(i+1,:) = traceYNew(i,:)+VyNew*dt;
                  
              end
          
          end
          
          function directionArray =bounceCheck(pos,limLow,limHigh)
              tempCheck = zeros(1,numel(pos)) + 1;
              for i=1:numel(pos)
                  element = pos(i);
                  if element<=limLow||element>=limHigh
                      tempCheck(1,i)=-1;
                  end
              end
              directionArray = tempCheck;
          end
    end
end