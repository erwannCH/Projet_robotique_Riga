view(150,30)
limite=1500;
axis([-limite limite -limite limite -limite limite])

tetas=[0 12.6641 -11.3436 0 -91.3205 -0];
T06=ABB(tetas);

for X=0:5:200
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    
    ABBplot(tetas);
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
end
T06=M;

for X=0:5:100
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
end
T06=M;

for X=0:5:400
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
end
T06=M;

for X=0:5:100
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
end
T06=M;

for X=0:5:200
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    ABBplot(tetas);
end
T06=M;
