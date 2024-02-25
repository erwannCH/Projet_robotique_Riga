function [A06]=IRB(tetas)
%
t1=tetas(1);
t2=tetas(2);
t3=tetas(3)-t2;
t4=tetas(4);
t5=tetas(5);
t6=tetas(6);
% close
grid on
limite=1900;
axis([-limite limite -limite limite -limite limite])
view(130,30)
A0=eye(4);

A01=RotaZ(t1)*[1 0 0 200;...
               0 0 1 0;...
               0 -1 0 680;...
               0 0 0 1];
A12=RotaZ(t2)*[0 1 0 0;...
              -1 0 0 -890;...
               0 0 1 0;...
               0 0 0 1];
A23=RotaZ(t3)*[1 0 0 150;...
               0 0 1 0;...
               0 -1 0 0;...
               0 0 0 1];
A34=RotaZ(t4)*[1 0 0 0;...
               0 0 -1 0;...
               0 1 0 880;...
               0 0 0 1];
A45=RotaZ(t5)*[-1 0 0 0;...
               0 0 1 0;...
               0 1 0 0;...
               0 0 0 1];
A56=RotaZ(t6)*[1 0 0 0;...
               0 1 0 0;...
               0 0 1 140;...
               0 0 0 1];


 A02=A01*A12;
 A03=A02*A23;
 A04=A03*A34;
 A05=A04*A45;
 A06=A05*A56;
% motoman sia20D
sistema42(A0)
%  sistema42(A01)
%  sistema42(A02)
%  sistema42(A03)
%  sistema42(A04)
%  sistema42(A05)
sistema42(A06)



%dibuja linea1
 p1=A0*RotaZ1(680);
 p1x=p1(1,4);
p1y=p1(2,4);
p1z=p1(3,4);

p3=p1*RotaZ(t1)*TrasX(200);
 p3x=p3(1,4);
p3y=p3(2,4);
p3z=p3(3,4);
% 
  line ([A0(1,4) p1x],[A0(2,4) p1y],[A0(3,4) p1z],'color','k','linewidth',1);

 line ([p1x A01(1,4)],[p1y A01(2,4)],[p1z A01(3,4)],'color','k','linewidth',1);
 
 line ([A01(1,4) p3x],[A01(2,4) p3y],[A01(3,4) p3z],'color','k','linewidth',1);

 line ([p3x A02(1,4)],[p3y A02(2,4)],[p3z A02(3,4)],'color','k','linewidth',1);
  
 line ([A02(1,4) A03(1,4)],[A02(2,4) A03(2,4)],[A02(3,4) A03(3,4)],'color','k','linewidth',1);
 
 line ([A03(1,4) A04(1,4)],[A03(2,4) A04(2,4)],[A03(3,4) A04(3,4)],'color','k','linewidth',1);
   line ([A04(1,4) A05(1,4)],[A04(2,4) A05(2,4)],[A04(3,4) A05(3,4)],'color','k','linewidth',1);
   line ([A05(1,4) A06(1,4)],[A05(2,4) A06(2,4)],[A05(3,4) A06(3,4)],'color','k','linewidth',1);
   drawnow
end