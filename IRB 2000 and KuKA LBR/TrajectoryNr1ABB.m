limite=1500;
axis([-limite limite -limite limite -limite limite])

tetas=[0 12.6641 -11.3436 0 -91.3205 -0];
T06=ABB(tetas);

% Initialisation des matrices pour stocker les points significatifs
points_x = [];
points_y = [];

for X=0:5:200
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
    % Calcul du déterminant de la matrice jacobienne
    det_J = determinant_Jacobienne(tetas, @ABB, M, 1e-5);
     % Ajouter le point à la liste s il est significatif
    if abs(det_J) > 1e-6
        points_x = [points_x, M(1, 4)];
        points_y = [points_y, M(2, 4)];
    end
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
    det_J = determinant_Jacobienne(tetas, @ABB, M, 1e-5);
    if abs(det_J) > 1e-6
        points_x = [points_x, M(1, 4)];
        points_y = [points_y, M(2, 4)];
    end
end
T06=M;

for X=0:5:100
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
    det_J = determinant_Jacobienne(tetas, @ABB, M, 1e-5);
    if abs(det_J) > 1e-6
        points_x = [points_x, M(1, 4)];
        points_y = [points_y, M(2, 4)];
    end
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
    det_J = determinant_Jacobienne(tetas, @ABB, M, 1e-5);
    if abs(det_J) > 1e-6
        points_x = [points_x, M(1, 4)];
        points_y = [points_y, M(2, 4)];
    end
end
T06=M;

for X=0:5:400
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
    det_J = determinant_Jacobienne(tetas, @ABB, M, 1e-5);
    if abs(det_J) > 1e-6
        points_x = [points_x, M(1, 4)];
        points_y = [points_y, M(2, 4)];
    end
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
    det_J = determinant_Jacobienne(tetas, @ABB, M, 1e-5);
    if abs(det_J) > 1e-6
        points_x = [points_x, M(1, 4)];
        points_y = [points_y, M(2, 4)];
    end
end
T06=M;

for X=0:5:100
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
    det_J = determinant_Jacobienne(tetas, @ABB, M, 1e-5);
    if abs(det_J) > 1e-6
        points_x = [points_x, M(1, 4)];
        points_y = [points_y, M(2, 4)];
    end
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
    det_J = determinant_Jacobienne(tetas, @ABB, M, 1e-5);
    if abs(det_J) > 1e-6
        points_x = [points_x, M(1, 4)];
        points_y = [points_y, M(2, 4)];
    end
end
T06=M;

for X=0:5:200
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
    det_J = determinant_Jacobienne(tetas, @ABB, M, 1e-5);
    if abs(det_J) > 1e-6
        points_x = [points_x, M(1, 4)];
        points_y = [points_y, M(2, 4)];
    end
end
T06=M;

% Tracer la carte des points significatifs
scatter(points_x, points_y, 'filled');
xlabel('X');
ylabel('Y');
title('Carte des points significatifs de la trajectoire');

