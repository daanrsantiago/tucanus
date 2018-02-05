%Teste do zero

clear
clc

load('prop_data.mat')
load('engine_data.mat')

%% escolha da hélice

helice = buscam(prop_nome,'apce_9x4.5_jb0997_5008.txt');
pCp = pCp(helice,:);
pCt = pCt(helice,:);
D = prop_diametro(helice)*0.0254;
J_max = J_max(helice);
J_min = J_min(helice);
prop_RPM = prop_RPM(helice);
clear prop_nome prop_diametro peta prop_passo prop_marca Cts Cps RPMs


%% escolha do motor

motor = buscam(sm,'Scorpion SII-3026-890KV');
kv = kv(motor);
r = r(motor);
i0 = i0(motor);
imax = imax(motor);

clear sm

%% velocidades e voltagens escolhidas

V = (J_min*prop_RPM*D/60:0.05:J_max*prop_RPM*D/60);
v = (2.4:2.4:20);

%% inicialização de parametros

ro = 1.2928;
J = J_min:0.001:J_max;
J1 = zeros(1,length(V));
n = zeros(length(V),length(J));
n1 = zeros(1,length(V));
Qp = zeros(length(V),length(J));
Qm = zeros(length(V),length(J));
T = zeros(1,length(V));
Cq = polyval(pCp,J)/(2*pi); %os valores de Cq permacem os mesmos independentemente de V e v

%% equações que modelam o problema

%teste

for IV=1:length(V)
    n(IV,:) = V(IV)./(J.*D); %n armazena todos os valores de velocidade de rotação possiveis para os valores de J encontrados no banco de dados
    Qp(IV,:) = ro.*n(IV,:).^2*D^5.*Cq; 
    Qm(IV,:) = ((v(6) - 60.*n(IV,:)./kv)./r - i0)./kv; %Equação de Qm adaptada para velocidade de rotação em hz
    [M,I] = min(abs(Qp(IV,:)-Qm(IV,:))); % I é o index vetor Qp-Qm onde ocorre Qm=Qp (regime permanente)
    M
    n1(IV) = n(IV,I); %n1 guarda a velocidade de rotação em hz do regime permanente de cada velocidade V
    J1(IV) = J(I); %J1 armazena os valores de J no regime permanente para cada velocidade
    T(IV) = ro*n1(IV)^2*D^4*polyval(pCt,J1(IV));
end





