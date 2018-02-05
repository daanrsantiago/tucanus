%Daniel Ribeiro Santiago
%Ex 2 topico 5

clear
clc

R = 8.31;
n = 1;

v = linspace(0.5*10^-3,2*10^-3,300);
t = linspace(273,473,300);
[V T] = meshgrid(v,t);
P = 1.*R.*T./V;

mesh(V,T,P)
grid on
xlabel Volume
ylabel Temperatura
zlabel Pressao
title('pressao em funcao da temperatura e volume')
