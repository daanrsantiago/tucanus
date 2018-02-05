%teste modelameto do grupo moto-prop

clear
clc

syms nsym Jsym vsym

load('Motor1.mat');
load('Helice1.mat');

V=35

format bank

Qm = ((vsym - nsym/(2*3.14*Kv))/R - I0)/Kv;
Jsym = V/(nsym*D);
Cq = pCq(1)*Jsym^3 + pCq(2)*Jsym^2 + pCq(3)*Jsym^1+ pCq(4);
Qp = ro*nsym^2*D^5*Cq == Qm;
n = double(solve(subs(Qp,vsym,v(6)),nsym,'Real',true));
n = real(n(1))
rotRPM = n*60
J = double(subs(Jsym,nsym,n))
T = ro*n^2*D^4*polyval(pCt,J)


