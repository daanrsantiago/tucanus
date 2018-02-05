% Daniel Ribeiro Santiago 11711EAR039
% Ex5 lista topico 7

clear
clc

syms m k c x t

x = dsolve('m*D2x+c*Dx+k*x=0','x(0)=0.18','Dx(0)=0');
X = subs(x,[m,k,c],[10,28,3]);
fplot(X,[0 20])
grid on
xlabel 't[s]'
ylabel 'x[m]'
axis([0 20 -0.2 0.2])




