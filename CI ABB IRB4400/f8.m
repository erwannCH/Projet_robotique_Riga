function [F]=f8(t1,t2,t3,t4,t5,t6,M)
  ay=M(2,3);
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(2,3)-ay;
end