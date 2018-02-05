%teste modelamento do grupo moto-prop

clear
clc

format bank

syms nsym J v

%% load de dados de motor e helice a serem utilizados

load('engine_data.mat');
load('Helice1.mat');

%% escolha do motor dentre os do arquivo 'dados_motores.mat'

motor = buscam(sm,'Scorpion SII-3026-890KV');
kv = kv(motor);
r = r(motor);
i0 = i0(motor);
imax = imax(motor);

clear sm

%% escolha de parametros de velocidade e voltagem analizada

V=40;
v = 2.4:2.4:30; %a escolha só pode ser feita a partir de multiplos de 2.4 volt
v = v(4);

%% Equações simbolicas que modelam o problema

Qm = ((v - 2*pi*nsym/kv)/r - i0)/kv;
J = V/(nsym*D);
Cq = pCq(1)*J^3 + pCq(2)*J^2 + pCq(3)*J^1+ pCq(4);
Qp = ro*nsym^2*D^5*Cq;
Equilibrio= Qp == Qm;

%% solução real de n(rotação em hz) da equação no equilibrio

n = real(double(solve(Equilibrio,nsym,'PrincipalValue', true)));
rotRPM = n*60;
J = double(subs(J,nsym,n));
Q = ro*n^2*D^5*polyval(pCq,J)
T = ro*n^2*D^4*polyval(pCt,J);

%% print dos resultados

fprintf('\r RESULTADOS NO EQUILÍBRIO PARA A VELOCIDADE %1.1f m/s e voltagem %1.1f volts \n',V, v)
fprintf('\r Velocidade de escoamento em Km/h: %.4g \n',V*3.6)
fprintf('\r Rotação em hz: %.4g \n',n)
fprintf('\r Rotação em RPM: %.7g \n',rotRPM)
fprintf('\r Razão de avanço: %.2g \n',J)
fprintf('\r Tração: %.3g N \n',T)
