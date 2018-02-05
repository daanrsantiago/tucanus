%teste velocidades separadas

clear
clc

load('prop_data.mat')
load('engine_data.mat')

%% escolha da hélice

helice = [buscam(prop_nome,'apce_11x5.5_kt0472_6000.txt'),0];
helice(2) = helice(1)+1;
pCp = pCp(helice,:);
pCt = pCt(helice,:);
D = prop_diametro(helice(1))*0.0254;
J_max = J_max(helice)';
J_min = J_min(helice)';
prop_RPM = prop_RPM(helice(1));
clear prop_nome prop_diametro peta prop_passo prop_marca Cts Cps RPMs


%% escolha do motor

motor = buscam(sm,'Scorpion SII-3026-890KV');
kv = kv(motor)*2*pi/60;
r = r(motor);
i0 = i0(motor);
imax = imax(motor);

clear sm

%% velocidades e voltagens escolhidas

% V é um vetor cuja a primeira linha contem as velocidades de escoamento
% possiveis para o primeiro arquivo de dados da hélice e a segunda linha as
% velocidades de escoamento possiveis para o segundo arquivo de dados da
% hélice

% é importante verificar que a velocidade maxima do primeiro arquivo é a
% velocidade minima do segundo arquivo.
V_max = [J_max(1).*(prop_RPM).*D/60,J_max(2).*(prop_RPM+1400).*D/60];
V_min = [J_min(1).*prop_RPM.*D/60,V_max(1)];
V = [linspace(V_min(1),V_max(1),500);linspace(V_min(2),V_max(2),500)];
v = (2.4:2.4:20);

%% inicialização de parametros

[~,~,~,rho] = atmosisa(1000);
nhz = (prop_RPM-1500)/60:0.01:((prop_RPM+1500)/60);
ome = 2*pi*nhz;
RPM = nhz*60;
T = zeros(1,2*length(V)); %armazena os valores de tração, importante notar que ele ter esse tamanho porque percorre os valores das duas linhas de V
ome1 = zeros(1,2*length(V)); %armazena os valores de omega em que ocorrem o regime permantente a cada velocidade

%% Equações que modelam o problema
for lV = 1:2 %percorre cada linha de V
    for iV = 1:length(V(1,:)) %percorre cada coluna de uma linha de V
        J = V(lV,iV)./(D.*nhz);
        Cp = polyval(pCp(lV,:),J);
        Qp = 1/2*rho.*ome.^2*pi*(D/2)^5.*Cp;
        Qm = ((v(4) - ome./kv)./r - i0)./kv;
        [M,I] = min(abs(Qm-Qp));
        M
        J1 = J(I);
        ome1(lV,iV) = ome(I);
        Ct = polyval(pCt(lV,:),J1);
        T(iV+(lV-1)*length(V(1,:))) = 1/2*rho*ome1(lV,iV)^2*pi*(D/2)^4*Ct/9.81;
    end
end
RPM1 = ome1*60/(2*pi); %valores em RPM das velocidades onde ocorre o regime permanente
V_tot = [V(1,:),V(2,:)];

hold on
plot(V_tot,T)
xlabel 'Velocidade (m/s)'
ylabel 'Tração (Kg)'

grid on

