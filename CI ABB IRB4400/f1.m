function [F]=f1(t1,t2,t3,t4,t5,t6,M)
tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  nx=M(1,1);
  F=T06(1,1)-nx;
end
