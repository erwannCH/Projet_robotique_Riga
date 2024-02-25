function [A06]=IRB(t1,t2,t3,t4,t5,t6)
%
% close
grid on
limite=1800
axis([-limite limite -limite limite -limite limite])
view(130,30)
A0=eye(4);
% A12=[cosd(t2-90) -sind(t2-90) 0 -425.5*sind(t2-90);sind(t2-90) cosd(t2-90) 0 425.5*cosd(t2-90);0 0 1 118.95;0 0 0 1];
% A23=[cosd(t3) sind(t3) 0 -392.25*sind(t3);sind(t3) cosd(t3) 0 392.25*cosd(t3);0 0 1 0;0 0 0 1];
% A34=[-sind(t4) 0 cosd(t4) 0;cosd(t4) 0 sind(t4) 0;0 1 0 -94.75;0 0 0 1];
% A45=[sind(t5+270) 0 cosd(t5+270) 0;-cosd(t5+270) 0 sind(t5+270) 0;0 -1 0 94.75;0 0 0 1];
% A56=[cosd(t6) -sind(t6) 0  0;sind(t6) cosd(t6) 0 0;0 0 1 82.5;0 0 0 1];
% A01=[0 cosd(t1) -sind(t1) 134.2*sind(t1);0 sind(t1) cosd(t1) -134.2*cosd(t1); 1 0 0 89.2;0 0 0 1];

A01=RCZ(t1)*[1 0 0 200;0 0 1 0;0 -1 0 680;0 0 0 1]
A12=RCZ(t2)*[0 1 0 0;-1 0 0 -890;0 0 1 0;0 0 0 1]
A23=RCZ(t3)*[1 0 0 150;0 0 1 0;0 1 0 0;0 0 0 1]
A34=RCZ(t4)*[1 0 0 0;0 0 -1 0;0 1 0 880;0 0 0 1]
A45=RCZ(t5)*[1 0 0 0;0 0 1 0;0 -1 0 0;0 0 0 1]
A56=RCZ(t6)*[1 0 0 0;0 1 0 0;0 0 1 140;0 0 0 1]
% A02=A01*A12;
% A03=A01*A12*A23;
% A04=A01*A12*A23*A34;
% A05=A01*A12*A23*A34*A45;
% A06=A01*A12*A23*A34*A45*A56;
 A02=A01*A12;
 A03=A02*A23;
 A04=A03*A34;
 A05=A04*A45;
 A06=A05*A56;
% motoman sia20D
sistema42(A0)
sistema42(A01)
sistema42(A02)
sistema42(A03)
sistema42(A04)
sistema42(A05)
sistema42(A06)
drawnow


%dibuja linea1
 p1=A0*RotaZ1(680)
 p1x=p1(1,4)
p1y=p1(2,4)
p1z=p1(3,4)

p3=p1*RCZ(t1)*RotaX1(200)
 p3x=p3(1,4)
p3y=p3(2,4)
p3z=p3(3,4)
% 
  line ([A0(1,4) p1x],[A0(2,4) p1y],[A0(3,4) p1z],'color','k','linewidth',1)

 line ([p1x A01(1,4)],[p1y A01(2,4)],[p1z A01(3,4)],'color','k','linewidth',1)
 
 line ([A01(1,4) p3x],[A01(2,4) p3y],[A01(3,4) p3z],'color','k','linewidth',1)%%dibuja eje x
  line ([p3x A02(1,4)],[p3y A02(2,4)],[p3z A02(3,4)],'color','k','linewidth',1)
  
  line ([A02(1,4) A03(1,4)],[A02(2,4) A03(2,4)],[A02(3,4) A03(3,4)],'color','k','linewidth',1)%%dibuja eje x
 
   line ([A03(1,4) A04(1,4)],[A03(2,4) A04(2,4)],[A03(3,4) A04(3,4)],'color','k','linewidth',1)%%dibuja eje x
   line ([A04(1,4) A05(1,4)],[A04(2,4) A05(2,4)],[A04(3,4) A05(3,4)],'color','k','linewidth',1)%%dibuja eje x
   line ([A05(1,4) A06(1,4)],[A05(2,4) A06(2,4)],[A05(3,4) A06(3,4)],'color','k','linewidth',1)%%dibuja eje x