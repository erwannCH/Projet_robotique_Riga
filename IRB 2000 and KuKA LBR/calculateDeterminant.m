function det_J = calculateDeterminant(J)
    % Vérifie si la matrice est carrée
    if size(J, 1) ~= size(J, 2)
        error('La matrice doit être carrée pour calculer son déterminant.');
    end

    % Calcule le déterminant
    det_J = det(J);
end