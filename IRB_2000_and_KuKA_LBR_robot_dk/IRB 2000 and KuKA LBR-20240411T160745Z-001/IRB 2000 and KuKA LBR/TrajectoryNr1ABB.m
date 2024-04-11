view(150,30)
limite=1500;
axis([-limite limite -limite limite -limite limite])
grid on

RDK = Robolink();
robot = RDK.Item('ABB IRB 2600ID-8/2.00');

tetas=[0 0 0 0 0 0];
robot.setJoints(tetas);
T06=ABB(tetas); %6 axis for tool


for X=0:5:100
    M=T06*TrasX(X); %move around axis x 
    [tetas]=NewtonABB(tetas,M); %inverse kinematic
    robot.setJoints(tetas);
    ABBplot(tetas); %show robot 
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A); %circle move around point
    [tetas]=NewtonABB(tetas,M);
    robot.setJoints(tetas);
    ABBplot(tetas);
end
T06=M;

for X=0:5:400
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    robot.setJoints(tetas);
    ABBplot(tetas);
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    robot.setJoints(tetas);
    ABBplot(tetas);
end
T06=M;

for X=0:5:100
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    robot.setJoints(tetas);
    ABBplot(tetas);
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    robot.setJoints(tetas);
    ABBplot(tetas);
end
T06=M;

for X=0:5:400
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    robot.setJoints(tetas);
    ABBplot(tetas);
end
T06=M;

for A=0:5:90
    R=50;
    M=T06*TrasX(sind(A)*R)*TrasY(-(cosd(A)-1)*R)*RotaZ(A);
    [tetas]=NewtonABB(tetas,M);
    robot.setJoints(tetas);
    ABBplot(tetas);
end
T06=M;

for X=0:5:100
    M=T06*TrasX(X);
    [tetas]=NewtonABB(tetas,M);
    robot.setJoints(tetas);
    ABBplot(tetas);
end
T06=M;
