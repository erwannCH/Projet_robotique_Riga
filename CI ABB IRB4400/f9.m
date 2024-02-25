function [F]=f9(t1,t2,t3,t4,t5,t6,M)
  az=M(3,3);  
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(3,3)-az;
end