%traycetoria SIA20D
close all
clf
tetas=[0 80 -80 0 0 0];
[M]=CD_IRB(tetas);
[A06]=IRB(tetas);
%pause


for i=0:1:90
    T=M*ROTCX(i);
      [tetas]=Newton(T,tetas)
    [A06]=IRB(tetas);
   
end