function [F]=f7(t1,t2,t3,t4,t5,t6,M)
  ax=M(1,3);
  tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  F=T06(1,3)-ax;
end