%trayectoria IRB
RDK=Robolink;
robot=RDK.Item('ABB');
RDK.setSimulationSpeed(100);

tetas=[0 0 25 0 -25 0]
[A06]=IRB(tetas)
robot.MoveJ(tetas);  
%  pause
%  A06=[0    0    1    1300;...
%       0    1    1    -200;...
%      -1    0    0    1250;...
%       0    0    0    1];
% pause  
%   [tetas]=Newton(A06,tetas)
% 
%  robot.MoveJ(tetas);  
% pause
M=A06;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;

for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;

for n=0:50:250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;

for n=0:-50:-250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:5:90
    Mact=M*RotaY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:-50:-250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:-5:-90
    Mact=M*RotaX(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:-5:-90
    Mact=M*RotaY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end



M=Mact;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end
pause
M=Mact;
for n=0:-5:-90
    Mact=M*RotaY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end



M=Mact;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas)
clf
hold on
[A06]=IRB(tetas);
  %robot.MoveJ(tetas);  
 robot.setJoints(tetas);
end