function [T07]= KUKAplot(tetas)

    t1=tetas(1);
    t2=tetas(2);
    t3=tetas(3);
    t4=tetas(4);
    t5=tetas(5);
    t6=tetas(6);
    t7=tetas(7);

    hold on
   
    cla

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
   

    drawsyst(T00);
    drawsyst(T01);
    drawsyst(T02);
    drawsyst(T03);
    drawsyst(T04);
    drawsyst(T05);
    drawsyst(T06);
    drawsyst(T07);
 

    line([T00(1,4) T01(1,4)],[T00(2,4) T01(2,4)],[T00(3,4) T01(3,4)], 'color', 'k', 'linewidth', 1)
    line([T01(1,4) T02(1,4)],[T01(2,4) T02(2,4)],[T01(3,4) T02(3,4)], 'color', 'k', 'linewidth', 1)
    line([T02(1,4) T03(1,4)],[T02(2,4) T03(2,4)],[T02(3,4) T03(3,4)], 'color', 'k', 'linewidth', 1)
    line([T04(1,4) T03(1,4)],[T04(2,4) T03(2,4)],[T04(3,4) T03(3,4)], 'color', 'k', 'linewidth', 1)
    
    %P = T04*TrasX(-82.5);
    %line([P(1,4) T05(1,4)],[P(2,4) T05(2,4)],[P(3,4) T05(3,4)], 'color', 'k', 'linewidth', 1)
    %line([P(1,4) T04(1,4)],[P(2,4) T04(2,4)],[P(3,4) T04(3,4)], 'color', 'k', 'linewidth', 1)
    line([T04(1,4) T05(1,4)],[T04(2,4) T05(2,4)],[T04(3,4) T05(3,4)], 'color', 'k', 'linewidth', 1)

    
    line([T06(1,4) T05(1,4)],[T06(2,4) T05(2,4)],[T06(3,4) T05(3,4)], 'color', 'k', 'linewidth', 1)
    line([T06(1,4) T07(1,4)],[T06(2,4) T07(2,4)],[T06(3,4) T07(3,4)], 'color', 'k', 'linewidth', 1)
    
    grid on
    drawnow
end

