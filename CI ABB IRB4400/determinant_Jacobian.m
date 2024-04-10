function detJ = determinant_Jacobian(J)
    % method to obtain a square matrix from a non-square matrix
    % least squares method
    J_transpose = J';
    J_square = J_transpose * J;
    detMC = det(J_square);

    % The method of the maximum singular value (SVD)
    % Calculate the SVD decomposition of the Jacobian matrix
    [U, S, V] = svd(J);
    % Extract the singular values
    singular_values = diag(S);
    % Calculate the determinant using the singular values
    SVD_det = prod(singular_values);

    % The method of truncation
    % Determine the size of the Jacobian matrix
    [m, n] = size(J);
    %% Check if the matrix is square
    if m ~= n
        % The matrix is not square, truncate the matrix by removing the last rows
        J_truncated = J(1:n, :);
    else
        % The matrix is square, no truncation is necessary
        J_truncated = J;
    end
    %% Calculate the determinant of the truncated matrix
    truncated_det = det(J_truncated);

    % Calculate the mean of the determinants
    det_mean = mean([detMC, SVD_det, truncated_det]);
    %det_mean = mean([detMC, SVD_det]);
    detJ = [detMC, SVD_det, truncated_det, det_mean];
    %detJ = [detMC, SVD_det, det_mean];
    %detJ = [detMC, SVD_det, det_mean];
end
