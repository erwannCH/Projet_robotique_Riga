function [T07]= KUKA(tetas)
    %Kuka LBR iiwa 7 R800
    t1=tetas(1);
    t2=tetas(2);
    t3=tetas(3);
    t4=tetas(4);
    t5=tetas(5);
    t6=tetas(6);
    t7=tetas(7);

    %Direct Kinematics from Modified DH Convention
    T00=eye(4);
    T01=RotaX(0)*TrasX(0)*TrasZ(340)*RotaZ(t1);
    T12=RotaX(-90)*TrasX(0)*TrasZ(0)*RotaZ(t2);
    T23=RotaX(90)*TrasX(0)*TrasZ(400)*RotaZ(t3);
    T34=RotaX(-90)*TrasX(0)*TrasZ(0)*RotaZ(t4);
    T45=RotaX(90)*TrasX(0)*TrasZ(400)*RotaZ(t5);
    T56=RotaX(-90)*TrasX(0)*TrasZ(0)*RotaZ(t6);
    T67=RotaX(90)*TrasX(0)*TrasZ(130)*RotaZ(t7);
    
    T01=T00*T01;
    T02=T01*T12;
    T03=T02*T23;
    T04=T03*T34;
    T05=T04*T45;
    T06=T05*T56;
    T07=T06*T67; 

end