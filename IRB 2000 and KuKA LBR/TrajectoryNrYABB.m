view(150,30)
limite=1590;
axis([-limite limite -limite limite -limite limite])
grid on

tetas=[0 0 0 0 0 0];
T06=ABB(tetas);

% Initialisation de la structure de données pour stocker les valeurs du déterminant et les positions du robot 

name = 'TrajectoryNrYABB' 
filename = strcat(name, '.json'); 
data = struct('detMC', [], 'SVD_det', [], 'pInv_det', [], 'truncated_det', [] ,'detmean', [], 'posX', [], 'posY', [], 'posZ', []);

% Convertir la structure en chaîne JSON 

jsonStr = jsonencode(data);  

% Écrire la chaîne JSON dans un fichier 

fid = fopen( filename, 'w'); 
fprintf(fid, '%s', jsonStr); 
fclose(fid);


% Moving along X axis
for X=0:10:500
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M,filename)
    ABBplot(tetas);
end
T06=M;

% Moving along Y axis
for Y=0:10:500
    M=T06*TrasY(Y);
    [tetas]=NewtonABB(tetas,M,filename)
    ABBplot(tetas);
end
T06=M;

% Moving along Z axis
for Z=0:10:500
    M=T06*TrasZ(Z);
    [tetas]=NewtonABB(tetas,M,filename)
    ABBplot(tetas);
end
T06=M;

% Perform a new trajectory
for A=0:5:360
    R=50;
    M=T06*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonABB(tetas,M,filename)
    ABBplot(tetas);
end
T06=M;

% Another trajectory
for A=0:5:360
    R=75;
    M=T06*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M,filename)
    ABBplot(tetas);
end
T06=M;

% Yet another trajectory
for A=0:5:360
    R=100;
    M=T06*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonABB(tetas,M,filename)
    ABBplot(tetas);
end
T06=M;