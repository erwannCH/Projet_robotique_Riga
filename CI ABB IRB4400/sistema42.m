function[]=sistema41(R)
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
line ([px,(ux*100)+px],[py,py+uy*100],[pz,pz+uz*100],'color','r','linewidth',2)%%dibuja eje x
line ([px,px+vx*100],[py,py+vy*100],[pz,pz+vz*100],'color','g','linewidth',2)%%dibuja eje y
line ([px,px+wx*100],[py,py+wy*100],[pz,pz+wz*100],'color','b','linewidth',2)%%dibuja eje z