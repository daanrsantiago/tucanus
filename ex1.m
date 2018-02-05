%Daniel Ribeiro Santiago
%Ex 1 topico 5

clear
clc

t = 0:0.01:20;
x = (2+4.*cos(t)).*cos(t);
y = (2+4.*cos(t)).*sin(t);
z = t.^2;

plot3(x,y,z)
grid on
xlabel x
ylabel y
zlabel z

