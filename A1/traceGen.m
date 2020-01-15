classdef traceGen
    methods(Static)
          
          function [traceXNew,traceYNew] = iterate(interval,traceX,traceY, Vx, Vy, dt)
              % assign initial values
              traceXNew = traceX;
              traceYNew = traceY;
              for i=1:interval
                  directionX=traceGen.bounceCheck(traceXNew(i,:),0,200e-9);
                  directionY=traceGen.bounceCheck(traceYNew(i,:),0,100e-9);
                  newVx = directionX.*Vx;
                  newVy = directionY.*Vy;
                  traceXNew(i+1,:) = traceXNew(i,:)+newVx*dt;
                  traceYNew(i+1,:) = traceYNew(i,:)+newVy*dt;
                  
                  
              end
          
          end
          
          function directionArray =bounceCheck(pos,limLow,limHigh)
              tempCheck = zeros(1,numel(pos)) + 1;
              for i=1:numel(pos)
                  element = pos(i);
                  if element<=limLow||element>=limHigh
                      tempCheck(1,i)=-1;
                  else
                      tempCheck(1,i)=1;
                  end
              end
              directionArray = tempCheck;
          end
    end
end