clear
clc

load('engine_data.mat')

%% escolha do motor

motor = buscam(sm,'Scorpion SII-3026-890KV');
kv = kv(motor)*2*pi/60;
r = r(motor);
i0 = i0(motor);
imax = imax(motor);

clear sm

%% hélice

RPMs = [1868	2200	2450	2800	3095	3406	3716	4043	4350	4651	4968	5273	5577	5891	6213	6473];
Cps = [0.0327	0.0323	0.032	0.0314	0.031	0.0313	0.0312	0.0312	0.0312	0.0314	0.0313	0.0314	0.0317	0.0319	0.0322	0.0323];
Cts = [0.0777	0.0804	0.0824	0.0833	0.0838	0.0849	0.0857	0.0861	0.0862	0.087	0.0873	0.0877	0.0885	0.089	0.0897	0.0903];

pCps = polyfit(RPMs,Cps,1);
pCts = polyfit(RPMs(3:length(RPMs)),Cts(3:length(Cts)),1);
pCqs = pCps/(2*pi);

J = [0  0.02	0.05	0.07	0.1	0.12	0.14	0.17	0.19	0.22	0.24	0.27	0.29	0.31	0.34	0.36	0.39	0.41	0.43	0.46	0.48	0.51	0.53	0.55	0.58	0.6	0.63	0.65	0.67	0.7];
Ct = [0.107	0.1055	0.1039	0.1021	0.1002	0.098	0.0957	0.0931	0.0904	0.0875	0.0844	0.0811	0.0777	0.074	0.0702	0.0662	0.0621	0.0579	0.0536	0.0492	0.0447	0.0401	0.0355	0.0307	0.0258	0.0208	0.0157	0.0106	0.0054	0.0002];
Cp = [0.0552    0.0528	0.0506	0.0488	0.0474	0.0461	0.045	0.0439	0.0428	0.0418	0.0408	0.0398	0.0388	0.0378	0.0367	0.0355	0.0343	0.0329	0.0313	0.0296	0.0278	0.0258	0.0236	0.0212	0.0186	0.016	0.0131	0.01	0.0069	0.0039];

[J_max,~] = max(J);
[J_min,~] = min(J);

pCt = polyfit(J,Ct,5);
pCp = polyfit(J,Cp,2);
pCq = pCp/(2*pi);

D = 11*0.0254;
prop_RPM = 6000;

%% Ecolha da Voltagem e velocidade

v = 2.4:2.4:20;
V = 0.1:0.1:25;

%% Inicialização de variaveis

rho = 1.053;
T = zeros(1,length(V));
J = zeros(1,length(V));

%% Estático

RPMs = 1600:1:13000;
omes = RPMs*2*pi/60;
nhzs = RPMs/60;

Qm = ((v(6) - omes./kv)./r - i0)./kv;
Qps = rho*nhzs.^2*D^5.*polyval(pCqs,RPMs);
[M,I] = min(abs(Qm-Qps));

RPM = RPMs(I);
nhz = RPM/60;
ome = nhz*2*pi;

Ts = rho*nhz^2*D^4*0.1085/9.81;

%% Variando a velocidade

for I_V = 1:length(V)
    J(I_V) = V(I_V)/(nhz*D);
    if J(I_V) >= J_max
        Ct = polyval(pCt,J_max);
    else
        Ct = polyval(pCt,J(I_V));
    end
    T(I_V) = rho*nhz^2*D^4*Ct/9.81;
end

plot(V,T)
grid on
xlabel 'Velocidade [m/s]'
ylabel 'Tração [kg]'
hold on

%oi