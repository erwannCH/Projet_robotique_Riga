function [F]=f4(t1,t2,t3,t4,t5,t6,M)
  sx=M(1,2);
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(1,2)-sx;
end