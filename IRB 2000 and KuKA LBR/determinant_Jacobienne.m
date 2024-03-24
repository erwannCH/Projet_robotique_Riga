function detJ = determinant_Jacobienne(J)
    %méthode pour obtenir une matrice carrée à partir d'une matrice non carrée
    %methode des moindres carrés
    J_transpose = J';
    J_square = J_transpose * J;
    detMC = det(J_square);

    %La méthode de la valeur singulière maximale (SVD)
    % Calculer la décomposition SVD de la matrice Jacobienne
    [U, S, V] = svd(J);
    % Extraire les valeurs singulières
    singular_values = diag(S);
    % Calculer le déterminant à l'aide des valeurs singulières
    SVD_det = prod(singular_values);

%    %La méthode de la pseudo-inverse
%    pInvJ = pinv(J);
%    J_square = pInvJ * J;
%    pInv_det = det(J_square);
    
    %La méthode de la troncature
    % Déterminer la taille de la matrice Jacobienne
%    [m, n] = size(J);
%    % Vérifier si la matrice est carrée
%    if m ~= n
%        % La matrice n'est pas carrée, tronquer la matrice en éliminant les dernières lignes
%        J_truncated = J(1:n, :);
%    else
%        % La matrice est carrée, aucune troncature n'est nécessaire
%        J_truncated = J;
%    end
%    % Calculer le déterminant de la matrice tronquée
%    truncated_det = det(J_truncated);
    
    % Calculer la moyene des déterminant
    %det_mean = mean([detMC, SVD_det, pInv_det, truncated_det]);
    det_mean = mean([detMC, SVD_det]);
    %detJ = [detMC, SVD_det, pInv_det, truncated_det, det_mean];
    detJ = [detMC, SVD_det, det_mean];
end
