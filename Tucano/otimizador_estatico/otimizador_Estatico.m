clear
clc

load('engine_data.mat')
load('prop_data.mat','prop_nome','prop_diametro','pCts','pCps')

%% escolha do motor

motor = buscam(sm,'Scorpion SII-3026-890KV');
kv = kv(motor)*2*pi/60;
r = r(motor);
i0 = i0(motor);
imax = imax(motor);



%% Ecolha da Voltagem e velocidade

v = 2.4:2.4:20;
V = 0.1:0.1:25;

%% Inicialização de variaveis

rho = 1.053;
Ts1 = zeros(length(prop_nome),1);
RPM = zeros(1,137);
i = zeros(1,137);
n = 1;

%% Estático

RPMs = 1600:1:13000;
omes = RPMs*2*pi/60;
nhzs = RPMs/60;

Qm = ((v(6) - omes./kv)./r - i0)./kv;

for I_helice = 1:length(prop_nome)
    
    pCts1 = pCts(I_helice,:);
    pCps1 = pCps(I_helice,:);
    pCqs1 = pCps1/(2*pi);
    D = prop_diametro(I_helice)*0.0254;
    
    Qps = rho*nhzs.^2*D^5.*polyval(pCqs1,RPMs);
    [M,I] = min(abs(Qm-Qps));
    
    RPM(I_helice) = RPMs(I);
    nhz = RPM(I_helice)/60;
    ome = nhz*2*pi;

    i(1,I_helice) = (v(6)-ome/kv)/r;
    
    if i(1,I_helice) > imax
        Ts1(I_helice) = 0;
    else
        Ts1(I_helice) = rho*nhz^2*D^4*polyval(pCts1,RPM(I_helice))/9.81;
    end
    if Ts1(I_helice) ~= 0
        Ts(n) = Ts1(I_helice);
        n = n+1;
    end
end

[M_max,I_max] = max(Ts1);
prop_max = prop_nome(I_max)
D_max = prop_diametro(I_max)*0.0254;
Qp_max = rho*nhzs.^2*D_max^5.*polyval(pCps(I_max,:)/(2*pi),RPMs);


plot(RPMs,Qm);
grid minor
hold on
xlabel 'RPM'
ylabel 'Torque [N/M]'
plot(RPMs,Qp_max)