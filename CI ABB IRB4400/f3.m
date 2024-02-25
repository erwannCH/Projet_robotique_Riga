function [F]=f3(t1,t2,t3,t4,t5,t6,M)
  nz=M(3,1);
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(3,1)-nz;
end