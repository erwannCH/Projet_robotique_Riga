function [T06]=ABB(tetas) 
    %Robot ABB IRB 2600ID
    t1=tetas(1);
    t2=tetas(2);
    t3=tetas(3);
    t4=tetas(4);
    t5=tetas(5);
    t6=tetas(6);
    
    %Direct Kinematics from Modified DH convention
    T00 = eye(4);
    T01 = RotaX(0)*TrasX(0)*TrasZ(445)*RotaZ(t1);
    T12 = RotaX(-90)*TrasX(150)*TrasZ(0)*RotaZ(t2-90);
    T23 = RotaX(0)*TrasX(900)*TrasZ(0)*RotaZ(t3); 
    T34 = RotaX(-90)*TrasX(150)*TrasZ(938)*RotaZ(t4);
    T45 = RotaX(90)*TrasX(0)*TrasZ(0)*RotaZ(t5);
    T56 = RotaX(-90)*TrasX(0)*TrasZ(200)*RotaZ(t6+180);

    T01=T00*T01;
    T02=T01*T12;
    T03=T02*T23;
    T04=T03*T34;
    T05=T04*T45;
    T06=T05*T56;
    
end
