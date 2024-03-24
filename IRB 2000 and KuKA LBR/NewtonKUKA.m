function [tetas]=NewtonKUKA(tetas,M, filename)
    det_values = [];
    positionsX_values = [];
    positionsY_values = [];
    positionsZ_values = [];
    t1=tetas(1);
    t2=tetas(2);
    t3=tetas(3);
    t4=tetas(4);
    t5=tetas(5);
    t6=tetas(6);
    t7=tetas(7);
    
    damp=1;
    
    for n=1:100
        
        t1p=t1+damp;
        t2p=t2+damp;
        t3p=t3+damp;
        t4p=t4+damp;
        t5p=t5+damp;
        t6p=t6+damp;
        t7p=t7+damp;
        
        J(1,1)=(f1_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f1_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(1,2)=(f1_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f1_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(1,3)=(f1_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f1_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(1,4)=(f1_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f1_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(1,5)=(f1_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f1_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(1,6)=(f1_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f1_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(1,7)=(f1_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f1_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(2,1)=(f2_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f2_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(2,2)=(f2_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f2_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(2,3)=(f2_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f2_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(2,4)=(f2_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f2_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(2,5)=(f2_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f2_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(2,6)=(f2_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f2_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(2,7)=(f2_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f2_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(3,1)=(f3_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f3_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(3,2)=(f3_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f3_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(3,3)=(f3_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f3_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(3,4)=(f3_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f3_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(3,5)=(f3_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f3_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(3,6)=(f3_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f3_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(3,7)=(f3_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f3_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(4,1)=(f4_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f4_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(4,2)=(f4_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f4_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(4,3)=(f4_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f4_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(4,4)=(f4_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f4_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(4,5)=(f4_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f4_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(4,6)=(f4_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f4_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(4,7)=(f4_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f4_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(5,1)=(f5_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f5_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(5,2)=(f5_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f5_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(5,3)=(f5_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f5_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(5,4)=(f5_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f5_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(5,5)=(f5_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f5_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(5,6)=(f5_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f5_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(5,7)=(f5_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f5_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(6,1)=(f6_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f6_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(6,2)=(f6_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f6_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(6,3)=(f6_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f6_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(6,4)=(f6_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f6_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(6,5)=(f6_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f6_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(6,6)=(f6_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f6_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(6,7)=(f6_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f6_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(7,1)=(f7_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f7_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(7,2)=(f7_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f7_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(7,3)=(f7_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f7_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(7,4)=(f7_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f7_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(7,5)=(f7_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f7_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(7,6)=(f7_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f7_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(7,7)=(f7_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f7_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(8,1)=(f8_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f8_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(8,2)=(f8_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f8_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(8,3)=(f8_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f8_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(8,4)=(f8_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f8_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(8,5)=(f8_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f8_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(8,6)=(f8_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f8_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(8,7)=(f8_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f8_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(9,1)=(f9_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f9_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(9,2)=(f9_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f9_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(9,3)=(f9_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f9_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(9,4)=(f9_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f9_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(9,5)=(f9_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f9_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(9,6)=(f9_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f9_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(9,7)=(f9_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f9_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(10,1)=(f10_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f10_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(10,2)=(f10_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f10_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(10,3)=(f10_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f10_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(10,4)=(f10_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f10_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(10,5)=(f10_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f10_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(10,6)=(f10_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f10_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(10,7)=(f10_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f10_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(11,1)=(f11_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f11_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(11,2)=(f11_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f11_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(11,3)=(f11_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f11_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(11,4)=(f11_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f11_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(11,5)=(f11_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f11_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(11,6)=(f11_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f11_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(11,7)=(f11_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f11_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        J(12,1)=(f12_1(t1p,t2,t3,t4,t5,t6,t7,M)-(f12_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(12,2)=(f12_1(t1,t2p,t3,t4,t5,t6,t7,M)-(f12_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(12,3)=(f12_1(t1,t2,t3p,t4,t5,t6,t7,M)-(f12_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(12,4)=(f12_1(t1,t2,t3,t4p,t5,t6,t7,M)-(f12_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(12,5)=(f12_1(t1,t2,t3,t4,t5p,t6,t7,M)-(f12_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(12,6)=(f12_1(t1,t2,t3,t4,t5,t6p,t7,M)-(f12_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        J(12,7)=(f12_1(t1,t2,t3,t4,t5,t6,t7p,M)-(f12_1(t1,t2,t3,t4,t5,t6,t7,M)))/damp;
        
        f(1)=f1_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(2)=f2_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(3)=f3_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(4)=f4_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(5)=f5_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(6)=f6_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(7)=f7_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(8)=f8_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(9)=f9_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(10)=f10_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(11)=f11_1(t1,t2,t3,t4,t5,t6,t7,M);
        f(12)=f12_1(t1,t2,t3,t4,t5,t6,t7,M);

        % Calculer le déterminant de la matrice des moindres carrés
        J_sub = J(1:7, 1:7); % Extrait la sous-matrice 7x7
       det = calculateDeterminant(J_sub);

       % Ajouter la valeur du déterminant à la liste
       det_values(end+1) = det;

       % Extraire les positions X, Y et Z du robot de la matrice de transformation M
       positionX = M(1,4);
       positionY = M(2,4);
       positionZ = M(3,4);

       % Ajouter la valeur des positions à la liste
       positionsX_values(end+1) = positionX;
       positionsY_values(end+1) = positionY;
       positionsZ_values(end+1) = positionZ;
        
        %ds=-J/f';
        ds=pinv(J)*(-f');
        
        t1=t1+ds(1);
        t2=t2+ds(2);
        t3=t3+ds(3);
        t4=t4+ds(4);
        t5=t5+ds(5);
        t6=t6+ds(6);
        t7=t7+ds(7);
        
        t=[t1 t2 t3 t4 t5 t6 t7]; 
        kk=t;

        %Normalize
        rnd=kk/360;
        entrnd=fix(rnd);
        kk2=rnd-entrnd;
        kk2n=kk2*360;  
        tetas=kk2n;

        if (abs(f(1))<1.0e-9 && abs (f(2))<1.0e-9 && abs (f(3))<1.0e-9 && abs (f(4))<1.0e-9 && abs (f(5))<1.0e-9 && abs (f(6))<1.0e-9 && abs (f(7))<1.0e-9 && abs (f(8))<1.0e-9 && abs (f(9))<1.0e-9 && abs (f(10))<1.0e-9 && abs (f(11))<1.0e-9 && abs (f(12))<1.0e-9)
            break;
        end

    end
    
    % Ajouter les positions du robot à la structure de données et le déterminant
    data.posX = positionsX_values;
    data.posY = positionsY_values;
    data.posZ = positionsZ_values;
    data.detMC = det_values;

    % Enregistrer la liste des valeurs dans un fichier JSON
    jsonStr = jsonencode(data);
    fid = fopen(filename, 'a');  % Ouvrir le fichier en mode d'ajout
    fprintf(fid, '%s\n', jsonStr);  % Écrire une nouvelle ligne avec les nouvelles données
    fclose(fid);

    fprintf('t1=%5.3f, t2=%5.3f, t3=%5.3f, t4=%5.3f, t5=%5.3f, t6=%5.3f\n', kk2n(1),kk2n(2),kk2n(3),kk2n(4),kk2n(5),kk2n(6))
end


function [F]=f1_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    nx=M(1,1);
    F=A07(1,1)-nx;
end
function [F]=f2_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    ny=M(2,1);
    F=A07(2,1)-ny;
    
end
function [F]=f3_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    nz=M(3,1);
    F=A07(3,1)-nz;
    
end
function [F]=f4_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    rx=M(1,2);
    F=A07(1,2)-rx;
    
end
function [F]=f5_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    ry=M(2,2);
    F=A07(2,2)-ry;
    
end
function [F]=f6_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    rz=M(2,3);
    F=A07(2,3)-rz;
    
end
function [F]=f7_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    ax=M(1,3);
    F=A07(1,3)-ax;
end
function [F]=f8_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    ay=M(2,3);
    F=A07(2,3)-ay;
    
end
function [F]=f9_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    az=M(3,3);
    F=A07(3,3)-az;
    
end
function [F]=f10_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    px=M(1,4);
    F=A07(1,4)-px;
    
end
function [F]=f11_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    py=M(2,4);
    F=A07(2,4)-py;
    
end
function [F]=f12_1(t1,t2,t3,t4,t5,t6,t7,M)
    [A07]=KUKA([t1,t2,t3,t4,t5,t6,t7]);
    pz=M(3,4);
    F=A07(3,4)-pz;
    
end