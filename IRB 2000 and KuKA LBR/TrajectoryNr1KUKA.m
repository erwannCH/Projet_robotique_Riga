view(150,30)
limite=2000;
axis([-limite limite -limite limite -limite limite])


tetas=[0 0 0 90 0 -180 0];
T07=KUKA(tetas);


for X=0:5:30
    M=T07*TrasX(X);
    [tetas]=NewtonKUKA(tetas,M);
    KUKAplot(tetas);
end
T07=M;

for A=0:5:30
    R=50;
    M=T07*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M);
    KUKAplot(tetas);
end
T07=M;

for X=0:5:50
    M=T07*TrasX(X);
    [tetas]=NewtonKUKA(tetas,M);
    KUKAplot(tetas);
end
T07=M;

for A=0:5:50
    R=50;
    M=T07*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M);
    KUKAplot(tetas);
end
T07=M;

for X=0:5:50
    M=T07*TrasX(X);
    [tetas]=NewtonKUKA(tetas,M);
    KUKAplot(tetas);
end
T07=M;

for A=0:5:50
    R=50;
    M=T07*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M);
    KUKAplot(tetas);
end
T07=M;

for X=0:5:50
    M=T07*TrasX(X);
    [tetas]=NewtonKUKA(tetas,M);
    KUKAplot(tetas);
end
T07=M;

for A=0:5:50
    R=50;
    M=T07*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonKUKA(tetas,M);
    KUKAplot(tetas);
end
T07=M;

for X=0:5:50
    M=T07*TrasX(X);
    [tetas]=NewtonKUKA(tetas,M);
    KUKAplot(tetas);
end
T07=M;
