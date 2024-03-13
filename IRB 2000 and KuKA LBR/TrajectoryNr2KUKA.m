view(320,10)
limite=2000;
axis([-limite limite -limite limite -limite limite])

tetas=[0 0 0 90 0 -180 0];
T07=KUKA(tetas);

% Initialisation de la structure de données pour stocker les valeurs du déterminant et les positions du robot
name = 'TrajectoryNr2KUKA'
filename = strcat(name, '.json');
data = struct('detMC', [], 'SVD_det', [], 'pInv_det', [], 'truncated_det', [] ,'detmean', [], 'posX', [], 'posY', [], 'posZ', []);

% Convertir la structure en chaîne JSON
jsonStr = jsonencode(data);

% Écrire la chaîne JSON dans un fichier
fid = fopen( filename, 'w');
fprintf(fid, '%s', jsonStr);
fclose(fid);

%top row
for A=0:1:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

for A=0:5:100
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;
for A=0:5:100
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;
for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;
for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

% travel down
for X=0:5:100
    R=30;
    M=T07*TrasX(-X);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%first rotate
for A=0:-3:-90
    R=30;
    M=T07*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%first half-cirlce
for A=0:5:90
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%second rotate
for A=0:-3:-45
    R=30;
    M=T07*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

% travel down
for X=0:5:60
    R=30;
    M=T07*TrasX(-X);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%third rotate
for A=0:-3:-90
    R=30;
    M=T07*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%second half-cirlce
for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%forth rotate
for A=0:-3:-90
    R=30;
    M=T07*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

% travel down
for X=0:5:150
    R=30;
    M=T07*TrasX(-X);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%bottom row
for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;
for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;
for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;
for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

% travel up
for X=0:5:200
    R=30;
    M=T07*TrasX(-X);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%first rotate
for A=0:-3:-90
    R=30;
    M=T07*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%first half-cirlce
for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%small half-circle
for A=0:5:180
    R=15;
    M=T07*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%second half-cirlce
for A=0:5:180
    R=30;
    M=T07*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

%second rotate
for A=0:-3:-90
    R=30;
    M=T07*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;

% travel up
for X=0:5:30
    R=30;
    M=T07*TrasX(-X);
    [tetas]=NewtonKUKA(tetas,M,filename);
    KUKAplot(tetas);
end
T07=M;
"FINISH"



