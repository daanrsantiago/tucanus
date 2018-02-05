%Daniel Ribeiro Santiago
%Ex 2 topico 5

clear
clc

t = 0:0.05:10;
fi = (5*pi/180).*t;
teta = (8*pi/180).*t;
r = 8 + 0.6.*t;

[X Y Z] = sph2cart(fi,teta,r);
plot3(X,Y,Z)
grid on
xlabel x
ylabel y
zlabel z