function [F]=f12(t1,t2,t3,t4,t5,t6,M)
  pz=M(3,4);
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(3,4)-pz;
end