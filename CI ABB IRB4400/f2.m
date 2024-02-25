function [F]=f2(t1,t2,t3,t4,t5,t6,M)
tetas=[t1 t2 t3 t4 t5 t6];
  T06=CD_IRB(tetas);
  ny=M(2,1);
  F=T06(2,1)-ny;
end
