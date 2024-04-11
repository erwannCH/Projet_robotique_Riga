view(130,30)
limite=1590;
axis([-limite limite -limite limite -limite limite])
grid on

tetas=[0 0 0 0 0 0];
T06=ABB(tetas);

% Initialisation de la structure de données pour stocker les valeurs du déterminant et les positions du robot 

name = 'TrajectoryNrXABB' 
filename = strcat(name, '.json'); 
data = struct(name, [], 'posX', [], 'posY', [], 'posZ', []);  

% Convertir la structure en chaîne JSON 

jsonStr = jsonencode(data);  

% Écrire la chaîne JSON dans un fichier 

fid = fopen( filename, 'w'); 
fprintf(fid, '%s', jsonStr); 
fclose(fid);


for X=0:5:200
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M,filename);
    
    ABBplot(tetas);
end
T06=M;

% travel up
for X=0:5:100
    R=50;
    M=T06*TrasX(-X);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end

%second rotate
for A=0:-3:-90
    R=50;
    M=T06*RotaZ(A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

%small half-circle
for A=0:5:180
    R=25;
    M=T06*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

%first half-cirlce
for A=0:5:180
    R=50;
    M=T06*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;


%first rotate
for A=0:-3:-90
    R=50;
    M=T06*RotaZ(A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

% travel down
for X=0:5:200
    R=50;
    M=T06*TrasX(-X);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

for X=0:5:400
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

%first rotate
for A=0:-3:-90
    R=50;
    M=T06*RotaZ(A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

%first half-cirlce
for A=0:5:180
    R=50;
    M=T06*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

%small half-circle
for A=0:5:180
    R=25;
    M=T06*TrasX(-sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(-A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

%second half-cirlce
for A=0:5:180
    R=50;
    M=T06*TrasX(-sind(A)*R)*TrasY((cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;

%second rotate
for A=0:-3:-90
    R=50;
    M=T06*RotaZ(A);
    [tetas]=NewtonABB(tetas,M,filename);
    ABBplot(tetas);
end
T06=M;