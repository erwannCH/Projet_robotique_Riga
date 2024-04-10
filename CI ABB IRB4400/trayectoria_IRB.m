%trayectoria IRB
%RDK=Robolink;
%%robot=RDK.Item('ABB');
%RDK.setSimulationSpeed(100);

tetas=[0 0 25 0 -25 0]
[A06]=IRB(tetas)

% Initialisation de la structure de données pour stocker les valeurs du déterminant et les positions du %robot
name = 'trayectoria_IRB'
filename = fullfile('C:\Users\erwan\OneDrive\Bureau\Pronjet_robotique_Riga\data\IRB', strcat(name, '.json'));
data = struct('detMC', [], 'SVD_det', [], 'pInv_det', [], 'truncated_det', [] ,'detmean', [], 'posX', [], 'posY', [], 'posZ', []);

% Convertir la structure en chaîne JSON
jsonStr = jsonencode(data);

% Écrire la chaîne JSON dans un fichier
fid = fopen( filename, 'w');
fprintf(fid, '%s', jsonStr);
fclose(fid);


%%robot.MoveJ(tetas);  
%  pause
%  A06=[0    0    1    1300;...
%       0    1    1    -200;...
%      -1    0    0    1250;...
%       0    0    0    1];
% pause  
%   [tetas]=Newton(A06,tetas)
% 
%  %robot.MoveJ(tetas);  
% pause
M=A06;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;

for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;

for n=0:50:250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;

for n=0:-50:-250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:5:90
    Mact=M*RotaY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:-50:-250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:-5:-90
    Mact=M*RotaX(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:-5:-90
    Mact=M*RotaY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end



M=Mact;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end
pause
M=Mact;
for n=0:-5:-90
    Mact=M*RotaY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end



M=Mact;
for n=0:-50:-250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasX(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end

M=Mact;
for n=0:50:250
    Mact=M*TrasY(n)
[tetas]=Newton(Mact,tetas,filename)
clf
hold on
[A06]=IRB(tetas);
  %%robot.MoveJ(tetas);  
 %robot.setJoints(tetas);
end