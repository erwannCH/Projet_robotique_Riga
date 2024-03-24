resolution = 10; % résolution de la grille en nombre de points par unité de longueur
minX = -2000; maxX = 2000; % limites de la grille en X
minY = -2000; maxY = 2000; % limites de la grille en Y
minZ = -2000; maxZ = 2000; % limites de la grille en Z

% Calculer le pas de la grille en fonction du pourcentage souhaité
stepSize = 20 / 100 * (maxX - minX) / resolution;

[X, Y, Z] = meshgrid(minX:stepSize:maxX, minY:stepSize:maxY, minZ:stepSize:maxZ);

% Initialiser la structure de données pour stocker les valeurs du déterminant et les positions du robot
name = 'TrajectoryAllPointsABB';
filename = fullfile('C:\Users\erwan\OneDrive\Bureau\Pronjet_robotique_Riga\data\abb', strcat(name, '.json'));
data = struct('detMC', [], 'SVD_det', [], 'pInv_det', [], 'truncated_det', [],'detmean', [], 'posX', [], 'posY', [], 'posZ', []);
jsonStr = jsonencode(data);
fid = fopen(filename, 'w');
fprintf(fid, '%s', jsonStr);
fclose(fid);

% Parcourir chaque point de la grille et calculer les angles des articulations du robot
for i = 1:size(X, 1)
    for j = 1:size(X, 2)
        for k = 1:size(X, 3)
            % Définir la position et l'orientation du robot pour le point courant
            T06 = TrasX(X(i,j,k)) * TrasY(Y(i,j,k)) * TrasZ(Z(i,j,k)) * eye(4);
            % Calculer les angles des articulations du robot à l'aide de la méthode de Newton
            tetas = NewtonABB(zeros(1,6), T06, filename);
            % Afficher le robot à la position courante
            %ABBplot(tetas);
            % Attendre un court instant pour visualiser le mouvement du robot
            %pause(0.01);
        end
    end
end
