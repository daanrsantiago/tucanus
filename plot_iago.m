clc
clear
phi=0:0.007:2*pi;
teta=0:0.007:pi;
r1=0.5;
r2=0.7
[phi teta]=meshgrid(phi,teta);
x=0.4+r1*sin(teta).*cos(phi);
y=r1*sin(teta).*sin(phi);
z=5+r1*cos(teta);
x1=1.6+r1*sin(teta).*cos(phi);
y1=r1*sin(teta).*sin(phi);
z1=5+r1*cos(teta);
x2=(1+r2*sin(teta).*cos(phi));
y2=(r2*sin(teta).*sin(phi))*0.8;
z2=4.4+1*(r2*cos(teta));
mesh(x,y,z)
daspect([1 1 1])
hold on
mesh(x1,y1,z1)
xlabel('x');
ylabel('y');
zlabel('z');
hold on
mesh(x2,y2,z2);