function determinant = determinant_Jacobienne(theta, forward_kinematics, T, epsilon)
    % Fonction pour calculer le déterminant de la matrice jacobienne
    
    % Initialisation des variables
    n = length(theta);
    J = zeros(6, n);
    delta_theta = epsilon * ones(1, n);
    
    % Calcul de la matrice jacobienne par différences finies
    for i = 1:n
        theta_plus = theta;
        theta_plus(i) = theta_plus(i) + delta_theta(i);
        T_plus = forward_kinematics(theta_plus);

        theta_minus = theta;
        theta_minus(i) = theta_minus(i) - delta_theta(i);
        T_minus = forward_kinematics(theta_minus);

        delta_T = T_plus - T_minus;
        
        % Vérifier les dimensions avant l assignation
        if size(delta_T) == size(J)
            J(:, i) = delta_T(:) / (2 * delta_theta(i));
        else
            disp("Dimensions incompatibles entre delta_T et J");
            % Gérer l erreur ou afficher un message d avertissement
        end
    end

    
    % Calcul du déterminant de la matrice jacobienne
    determinant = det(J);
end
