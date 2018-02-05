% Daniel Ribeiro Santiago 11711EAR039
% Ex2 lista topico 7

clear
clc

syms x y
eq = dsolve('Dy=3*y-1.5*x*y','y(0)=4','x');

ezplot(eq,[0,6])
grid on
xlabel 'eixo x'
ylabel 'eixo y'