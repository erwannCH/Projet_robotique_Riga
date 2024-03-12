function detJ = determinant_Jacobienne(J)
    %la matrice des moindres carrés et son déterminant
    J_transpose = J';
    J_square = J_transpose * J;
    detJ = det(J_square);
end
