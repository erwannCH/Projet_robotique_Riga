function [F]=f5(t1,t2,t3,t4,t5,t6,M)
  sy=M(2,2);
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(2,2)-sy;
end