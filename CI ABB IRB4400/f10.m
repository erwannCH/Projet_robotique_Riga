function [F]=f10(t1,t2,t3,t4,t5,t6,M)
  px=M(1,4);
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(1,4)-px;
end