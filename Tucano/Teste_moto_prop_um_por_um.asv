%teste velocidades separadas

clear
clc

load('prop_data.mat')
load('engine_data.mat')

%% escolha da hélice

helice = buscam(prop_nome,'mae_11x7_rd0583_5899.txt');
pCp = pCp(helice,:);
pCt = pCt(helice,:);
D = prop_diametro(helice)*0.0254;
J_max = J_max(helice);
J_min = J_min(helice);
prop_RPM = prop_RPM(helice);
clear prop_nome prop_diametro peta prop_passo prop_marca Cts Cps RPMs


%% escolha do motor

motor = buscam(sm,'Scorpion SII-3026-890KV');
kv = kv(motor)*2*pi/60;
r = r(motor);
i0 = i0(motor);
imax = imax(motor);

clear sm

%% velocidades e voltagens escolhidas

V = (J_min*prop_RPM*D/60:0.05:J_max*(prop_RPM+1400)*D/60);
v = (2.4:2.4:20);

%% inicialização de parametros

[~,~,~,rho] = atmosisa(1000);
nhz = (prop_RPM-1500)/60:0.01:((prop_RPM+1500)/60);
ome = 2*pi*nhz;
RPM = nhz*60;
T = zeros(1,length(V)); %armazena os valores de tração
ome1 = zeros(1,length(V)); %armazena os valores de omega em que ocorrem o regime permantente a cada velocidade

%% Equações que modelam o problema
for iV = 1:length(V)
    
    J = V(iV)./(D.*nhz);
    Cp = polyval(pCp,J);
    Qp = 1/2*rho.*ome.^2*pi*(D/2)^5.*Cp;
    Qm = ((v(4) - ome./kv)./r - i0)./kv;
    [M,I] = min(abs(Qm-Qp));
    M
    J1 = J(I);
    ome1(iV) = ome(I);
    Ct = polyval(pCt,J1);
    T(iV) = 1/2*rho*ome1(iV)^2*pi*(D/2)^4*Ct/9.81;
end

RPM1 = ome1*60/(2*pi); %valores em RPM das velocidades onde ocorre o regime permanente

hold on
plot(V,T)
xlabel 'Velocidade (m/s)'
ylabel 'Tração (Kg)'
grid on

