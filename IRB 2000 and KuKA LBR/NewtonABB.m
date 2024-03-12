
% Newton method implementation to linearize the non-linear equation system
% by computing the Jacobian matrix where the partial derivatives are 
% evaluated numerically by deferential approximation. 
% Lastly the over-determined equation system is solved using the
% Moore-Penrose pseudo-inverse.

function [tetas]=NewtonABB(thetas,M)
    %Function developed by Emmanuel Merchán
    %Solves the inverse kinematics problem for a desired position and
    % orientation given by matrix [M] and a initial guess for the values of
    % the joints of the robot
    % Initialisation de la liste pour stocker les valeurs du déterminant
    determinant_values = [];
    positionsX_values = [];
    positionsY_values = [];
    positionsZ_values = [];
    t1=thetas(1);
    t2=thetas(2);
    t3=thetas(3);
    t4=thetas(4);
    t5=thetas(5);
    t6=thetas(6);
    
    damp=1;
    
    
    for n=1:100
        
       t1p=t1+damp;
       t2p=t2+damp;
       t3p=t3+damp;
       t4p=t4+damp;
       t5p=t5+damp;
       t6p=t6+damp;
    
       J(1,1)=(f1(t1p,t2,t3,t4,t5,t6, M)-f1(t1,t2,t3,t4,t5,t6, M))/damp;
       J(1,2)=(f1(t1,t2p,t3,t4,t5,t6, M)-f1(t1,t2,t3,t4,t5,t6, M))/damp;
       J(1,3)=(f1(t1,t2,t3p,t4,t5,t6, M)-f1(t1,t2,t3,t4,t5,t6, M))/damp;
       J(1,4)=(f1(t1,t2,t3,t4p,t5,t6, M)-f1(t1,t2,t3,t4,t5,t6, M))/damp;
       J(1,5)=(f1(t1,t2,t3,t4,t5p,t6, M)-f1(t1,t2,t3,t4,t5,t6, M))/damp;
       J(1,6)=(f1(t1,t2,t3,t4,t5,t6p, M)-f1(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(2,1)=(f2(t1p,t2,t3,t4,t5,t6, M)-f2(t1,t2,t3,t4,t5,t6, M))/damp;
       J(2,2)=(f2(t1,t2p,t3,t4,t5,t6, M)-f2(t1,t2,t3,t4,t5,t6, M))/damp;
       J(2,3)=(f2(t1,t2,t3p,t4,t5,t6, M)-f2(t1,t2,t3,t4,t5,t6, M))/damp;
       J(2,4)=(f2(t1,t2,t3,t4p,t5,t6, M)-f2(t1,t2,t3,t4,t5,t6, M))/damp;
       J(2,5)=(f2(t1,t2,t3,t4,t5p,t6, M)-f2(t1,t2,t3,t4,t5,t6, M))/damp;
       J(2,6)=(f2(t1,t2,t3,t4,t5,t6p, M)-f2(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(3,1)=(f3(t1p,t2,t3,t4,t5,t6, M)-f3(t1,t2,t3,t4,t5,t6, M))/damp;
       J(3,2)=(f3(t1,t2p,t3,t4,t5,t6, M)-f3(t1,t2,t3,t4,t5,t6, M))/damp;
       J(3,3)=(f3(t1,t2,t3p,t4,t5,t6, M)-f3(t1,t2,t3,t4,t5,t6, M))/damp;
       J(3,4)=(f3(t1,t2,t3,t4p,t5,t6, M)-f3(t1,t2,t3,t4,t5,t6, M))/damp;
       J(3,5)=(f3(t1,t2,t3,t4,t5p,t6, M)-f3(t1,t2,t3,t4,t5,t6, M))/damp;
       J(3,6)=(f3(t1,t2,t3,t4,t5,t6p, M)-f3(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(4,1)=(f4(t1p,t2,t3,t4,t5,t6, M)-f4(t1,t2,t3,t4,t5,t6, M))/damp;
       J(4,2)=(f4(t1,t2p,t3,t4,t5,t6, M)-f4(t1,t2,t3,t4,t5,t6, M))/damp;
       J(4,3)=(f4(t1,t2,t3p,t4,t5,t6, M)-f4(t1,t2,t3,t4,t5,t6, M))/damp;
       J(4,4)=(f4(t1,t2,t3,t4p,t5,t6, M)-f4(t1,t2,t3,t4,t5,t6, M))/damp;
       J(4,5)=(f4(t1,t2,t3,t4,t5p,t6, M)-f4(t1,t2,t3,t4,t5,t6, M))/damp;
       J(4,6)=(f4(t1,t2,t3,t4,t5,t6p, M)-f4(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(5,1)=(f5(t1p,t2,t3,t4,t5,t6, M)-f5(t1,t2,t3,t4,t5,t6, M))/damp;
       J(5,2)=(f5(t1,t2p,t3,t4,t5,t6, M)-f5(t1,t2,t3,t4,t5,t6, M))/damp;
       J(5,3)=(f5(t1,t2,t3p,t4,t5,t6, M)-f5(t1,t2,t3,t4,t5,t6, M))/damp;
       J(5,4)=(f5(t1,t2,t3,t4p,t5,t6, M)-f5(t1,t2,t3,t4,t5,t6, M))/damp;
       J(5,5)=(f5(t1,t2,t3,t4,t5p,t6, M)-f5(t1,t2,t3,t4,t5,t6, M))/damp;
       J(5,6)=(f5(t1,t2,t3,t4,t5,t6p, M)-f5(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(6,1)=(f6(t1p,t2,t3,t4,t5,t6, M)-f6(t1,t2,t3,t4,t5,t6, M))/damp;
       J(6,2)=(f6(t1,t2p,t3,t4,t5,t6, M)-f6(t1,t2,t3,t4,t5,t6, M))/damp;
       J(6,3)=(f6(t1,t2,t3p,t4,t5,t6, M)-f6(t1,t2,t3,t4,t5,t6, M))/damp;
       J(6,4)=(f6(t1,t2,t3,t4p,t5,t6, M)-f6(t1,t2,t3,t4,t5,t6, M))/damp;
       J(6,5)=(f6(t1,t2,t3,t4,t5p,t6, M)-f6(t1,t2,t3,t4,t5,t6, M))/damp;
       J(6,6)=(f6(t1,t2,t3,t4,t5,t6p, M)-f6(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(7,1)=(f7(t1p,t2,t3,t4,t5,t6, M)-f7(t1,t2,t3,t4,t5,t6, M))/damp;
       J(7,2)=(f7(t1,t2p,t3,t4,t5,t6, M)-f7(t1,t2,t3,t4,t5,t6, M))/damp;
       J(7,3)=(f7(t1,t2,t3p,t4,t5,t6, M)-f7(t1,t2,t3,t4,t5,t6, M))/damp;
       J(7,4)=(f7(t1,t2,t3,t4p,t5,t6, M)-f7(t1,t2,t3,t4,t5,t6, M))/damp;
       J(7,5)=(f7(t1,t2,t3,t4,t5p,t6, M)-f7(t1,t2,t3,t4,t5,t6, M))/damp;
       J(7,6)=(f7(t1,t2,t3,t4,t5,t6p, M)-f7(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(8,1)=(f8(t1p,t2,t3,t4,t5,t6, M)-f8(t1,t2,t3,t4,t5,t6, M))/damp;
       J(8,2)=(f8(t1,t2p,t3,t4,t5,t6, M)-f8(t1,t2,t3,t4,t5,t6, M))/damp;
       J(8,3)=(f8(t1,t2,t3p,t4,t5,t6, M)-f8(t1,t2,t3,t4,t5,t6, M))/damp;
       J(8,4)=(f8(t1,t2,t3,t4p,t5,t6, M)-f8(t1,t2,t3,t4,t5,t6, M))/damp;
       J(8,5)=(f8(t1,t2,t3,t4,t5p,t6, M)-f8(t1,t2,t3,t4,t5,t6, M))/damp;
       J(8,6)=(f8(t1,t2,t3,t4,t5,t6p, M)-f8(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(9,1)=(f9(t1p,t2,t3,t4,t5,t6, M)-f9(t1,t2,t3,t4,t5,t6, M))/damp;
       J(9,2)=(f9(t1,t2p,t3,t4,t5,t6, M)-f9(t1,t2,t3,t4,t5,t6, M))/damp;
       J(9,3)=(f9(t1,t2,t3p,t4,t5,t6, M)-f9(t1,t2,t3,t4,t5,t6, M))/damp;
       J(9,4)=(f9(t1,t2,t3,t4p,t5,t6, M)-f9(t1,t2,t3,t4,t5,t6, M))/damp;
       J(9,5)=(f9(t1,t2,t3,t4,t5p,t6, M)-f9(t1,t2,t3,t4,t5,t6, M))/damp;
       J(9,6)=(f9(t1,t2,t3,t4,t5,t6p, M)-f9(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(10,1)=(f10(t1p,t2,t3,t4,t5,t6, M)-f10(t1,t2,t3,t4,t5,t6, M))/damp;
       J(10,2)=(f10(t1,t2p,t3,t4,t5,t6, M)-f10(t1,t2,t3,t4,t5,t6, M))/damp;
       J(10,3)=(f10(t1,t2,t3p,t4,t5,t6, M)-f10(t1,t2,t3,t4,t5,t6, M))/damp;
       J(10,4)=(f10(t1,t2,t3,t4p,t5,t6, M)-f10(t1,t2,t3,t4,t5,t6, M))/damp;
       J(10,5)=(f10(t1,t2,t3,t4,t5p,t6, M)-f10(t1,t2,t3,t4,t5,t6, M))/damp;
       J(10,6)=(f10(t1,t2,t3,t4,t5,t6p, M)-f10(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(11,1)=(f11(t1p,t2,t3,t4,t5,t6, M)-f11(t1,t2,t3,t4,t5,t6, M))/damp;
       J(11,2)=(f11(t1,t2p,t3,t4,t5,t6, M)-f11(t1,t2,t3,t4,t5,t6, M))/damp;
       J(11,3)=(f11(t1,t2,t3p,t4,t5,t6, M)-f11(t1,t2,t3,t4,t5,t6, M))/damp;
       J(11,4)=(f11(t1,t2,t3,t4p,t5,t6, M)-f11(t1,t2,t3,t4,t5,t6, M))/damp;
       J(11,5)=(f11(t1,t2,t3,t4,t5p,t6, M)-f11(t1,t2,t3,t4,t5,t6, M))/damp;
       J(11,6)=(f11(t1,t2,t3,t4,t5,t6p, M)-f11(t1,t2,t3,t4,t5,t6, M))/damp;
    
       J(12,1)=(f12(t1p,t2,t3,t4,t5,t6, M)-f12(t1,t2,t3,t4,t5,t6, M))/damp;
       J(12,2)=(f12(t1,t2p,t3,t4,t5,t6, M)-f12(t1,t2,t3,t4,t5,t6, M))/damp;
       J(12,3)=(f12(t1,t2,t3p,t4,t5,t6, M)-f12(t1,t2,t3,t4,t5,t6, M))/damp;
       J(12,4)=(f12(t1,t2,t3,t4p,t5,t6, M)-f12(t1,t2,t3,t4,t5,t6, M))/damp;
       J(12,5)=(f12(t1,t2,t3,t4,t5p,t6, M)-f12(t1,t2,t3,t4,t5,t6, M))/damp;
       J(12,6)=(f12(t1,t2,t3,t4,t5,t6p, M)-f12(t1,t2,t3,t4,t5,t6, M))/damp;
    
       f(1)=f1(t1,t2,t3,t4,t5,t6,M);
       f(2)=f2(t1,t2,t3,t4,t5,t6,M);
       f(3)=f3(t1,t2,t3,t4,t5,t6,M);
       f(4)=f4(t1,t2,t3,t4,t5,t6,M);
       f(5)=f5(t1,t2,t3,t4,t5,t6,M);
       f(6)=f6(t1,t2,t3,t4,t5,t6,M);
       f(7)=f7(t1,t2,t3,t4,t5,t6,M);
       f(8)=f8(t1,t2,t3,t4,t5,t6,M);
       f(9)=f9(t1,t2,t3,t4,t5,t6,M);
       f(10)=f10(t1,t2,t3,t4,t5,t6,M);
       f(11)=f11(t1,t2,t3,t4,t5,t6,M);
       f(12)=f12(t1,t2,t3,t4,t5,t6,M);

       % Calculer le déterminant de la matrice des moindres carrés
       detX = determinant_Jacobienne(J);

       % Ajouter la valeur du déterminant à la liste
       determinant_values(end+1) = detX;

       % Extraire les positions X, Y et Z du robot de la matrice de transformation M
       positionX = M(1,4);
       positionY = M(2,4);
       positionZ = M(3,4);

       % Ajouter la valeur des positions à la liste
       positionsX_values(end+1) = positionX;
       positionsY_values(end+1) = positionY;
       positionsZ_values(end+1) = positionZ;
    
       %J
       %funt_value=f'      
       %ds= -J\f';
       ds=pinv(J)*(-f');
    
    
       t1=t1+ds(1);
       t2=t2+ds(2);
       t3=t3+ds(3);
       t4=t4+ds(4);
       t5=t5+ds(5);
       t6=t6+ds(6);
    
    
       t=[t1 t2 t3 t4 t5 t6]; 
       kk=t;
    
        if (abs(f(1))<1.0e-9 && abs (f(2))<1.0e-9 && abs (f(3))<1.0e-9 && abs (f(4))<1.0e-9 && abs (f(5))<1.0e-9 && abs (f(6))<1.0e-9 && abs (f(7))<1.0e-9 && abs (f(8))<1.0e-9 && abs (f(9))<1.0e-9 && abs (f(10))<1.0e-9 && abs (f(11))<1.0e-9 && abs (f(12))<1.0e-9)
            break;
        end
    end

    % Ajouter les positions du robot à la structure de données et le déterminant
    data.posX = positionsX_values;
    data.posY = positionsY_values;
    data.posZ = positionsZ_values;
    data.detX = determinant_values;

    % Enregistrer la liste des valeurs dans un fichier JSON
    jsonStr = jsonencode(data);
    fid = fopen('detX.json', 'a');  % Ouvrir le fichier en mode d'ajout
    fprintf(fid, '%s\n', jsonStr);  % Écrire une nouvelle ligne avec les nouvelles données
    fclose(fid);

    % %Normalize
    rnd=kk/360;
    entrnd=fix(rnd);
    kk2=rnd-entrnd;
    kk2n=kk2*360;  
    tetas=kk2n;
    
    
    fprintf('t1=%5.3f, t2=%5.3f, t3=%5.3f, t4=%5.3f, t5=%5.3f, t6=%5.3f\n', kk2n(1),kk2n(2),kk2n(3),kk2n(4),kk2n(5),kk2n(6))

end

function [F]=f1(t1,t2,t3,t4,t5,t6,M)
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  nx=M(1,1);
  F=T06(1,1)-nx;
end

function [F]=f2(t1,t2,t3,t4,t5,t6,M)
  ny=M(2,1);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(2,1)-ny;
end

function [F]=f3(t1,t2,t3,t4,t5,t6,M)
  nz=M(3,1);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(3,1)-nz;
end

function [F]=f4(t1,t2,t3,t4,t5,t6,M)
  sx=M(1,2);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(1,2)-sx;
end

function [F]=f5(t1,t2,t3,t4,t5,t6,M)
  sy=M(2,2);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(2,2)-sy;
end

function [F]=f6(t1,t2,t3,t4,t5,t6,M)
  sz=M(3,2);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(3,2)-sz;
end

function [F]=f7(t1,t2,t3,t4,t5,t6,M)
  ax=M(1,3);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(1,3)-ax;
end

function [F]=f8(t1,t2,t3,t4,t5,t6,M)
  ay=M(2,3);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(2,3)-ay;
end

function [F]=f9(t1,t2,t3,t4,t5,t6,M)
  az=M(3,3);  
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(3,3)-az;
end

function [F]=f10(t1,t2,t3,t4,t5,t6,M)
  px=M(1,4);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(1,4)-px;
end

function [F]=f11(t1,t2,t3,t4,t5,t6,M)
  py=M(2,4);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(2,4)-py;
end

function [F]=f12(t1,t2,t3,t4,t5,t6,M)
  pz=M(3,4);
  T06=ABB([t1 t2 t3 t4 t5 t6]);
  F=T06(3,4)-pz;
end

