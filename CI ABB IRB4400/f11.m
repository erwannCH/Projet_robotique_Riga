function [F]=f11(t1,t2,t3,t4,t5,t6,M)
  py=M(2,4);
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(2,4)-py;
end