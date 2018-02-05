% Daniel Ribeiro Santiago 11711EAR039
% Ex1 lista topico 7

clear
clc

syms x
a = (1+(3*x^(1/2)/2)^2)^(1/2);
b = (x^2 + 8*x + 15)^(-1/2);
c = (sin(x) + cos(x) + 2)^(-1);
d = (sin(x))^4;

%% letra a)
A = int(a,x,1,4);
fprintf('\r letra a) %s \n \n',A)
%% letra b)
B = int(b,x);
fprintf('\r letra b) %s \n \n',B)
%% letra c)
C = int(c,x);
fprintf('\r letra c) %s \n \n',C)
%% letra d)
D = int(d,x);
fprintf('\r letra d) %s \n \n',D)