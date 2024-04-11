function []=drawsyst(R)
sc=60;
ux=R(1,1);
uy=R(2,1);
uz=R(3,1);

vx=R(1,2);
vy=R(2,2);
vz=R(3,2);

wx=R(1,3);
wy=R(2,3);
wz=R(3,3);
px=R(1,4);
py=R(2,4);
pz=R(3,4);
line ([px,(ux*sc)+px],[py,py+uy*sc],[pz,pz+uz*sc],'color','r','linewidth',2)%%dibuja eje x
line ([px,px+vx*sc],[py,py+vy*sc],[pz,pz+vz*sc],'color','g','linewidth',2)%%dibuja eje y
line ([px,px+wx*sc],[py,py+wy*sc],[pz,pz+wz*sc],'color','b','linewidth',2)%%dibuja eje z