function [F]=f6(t1,t2,t3,t4,t5,t6,M)
  sz=M(3,2);
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(3,2)-sz;
end