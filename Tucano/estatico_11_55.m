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

RPMs = [1867	2200	2450	2800	3095	3406	3716	4043	4350	4651	4968	5273	5577	5891	6213	6473];
Cps = [0.0327	0.0323	0.032	0.0314	0.031	0.0313	0.0312	0.0312	0.0312	0.0314	0.0313	0.0314	0.0317	0.0319	0.0322	0.0323];
Cts = [0.0777	0.0804	0.0824	0.0833	0.0838	0.0849	0.0857	0.0861	0.0862	0.087	0.0873	0.0877	0.0885	0.089	0.0897	0.0903];

pCps = polyfit(RPMs,Cps,1);
pCts = polyfit(RPMs(3:length(RPMs)),Cts(3:length(Cts)),1);
pCqs = pCps/(2*pi);

J = [0.088	0.111	0.132	0.154	0.176	0.199	0.22	0.242	0.263	0.284	0.304	0.327	0.349   0.369	0.372   0.392	0.395   0.415	0.419   0.435	0.438   0.462	0.48	0.506	0.528	0.549	0.57	0.592	0.614	0.637];
Ct = [0.0859	0.0846	0.0832	0.0815	0.0797	0.0773	0.0747	0.0708	0.0668	0.0621	0.0574	0.052	0.0481  0.0434	0.0433  0.0395	0.0393  0.0355	0.0354  0.0323	0.032   0.0279	0.025	0.0209	0.0172	0.0136	0.01	0.006	0.0021	-0.002];
Cp = [0.0333	0.0336	0.0338	0.0342	0.0345	0.0346	0.0346	0.0342	0.0335	0.0324	0.0311	0.0294	0.0282  0.0264	0.0265  0.025	0.0251  0.0235	0.0235  0.0223	0.0222  0.0204	0.0193	0.0176	0.016	0.0143	0.0125	0.0106	0.0086	0.0064];

[J_max,~] = max(J);
[J_min,~] = min(J);

pCt = polyfit(J,Ct,3);
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

RPM = 1600:1:13000;
ome = RPM*2*pi/60;
nhz = RPM/60;

Qm = ((v(6) - ome./kv)./r - i0)./kv;
Qps = rho*nhz.^2*D^5.*polyval(pCqs,RPM);
[M,I] = min(abs(Qm-Qps));

RPM = RPM(I);
nhz = RPM/60;
ome = nhz*2*pi;

Ts = rho*nhz^2*D^4*polyval(pCts,RPM)/9.81

%% Variando a velocidade

for I_V = 1:length(V)
    J(I_V) = V(I_V)/(nhz*D);
    if J(I_V) <= J_min
        Ct = polyval(pCts,RPM);
    elseif J(I_V) >= J_max
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