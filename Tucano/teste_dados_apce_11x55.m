%teste dados apc

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

%% dados da hélice

J = [0	0.02	0.05	0.07	0.1	0.12	0.14	0.17	0.19	0.22	0.24	0.27	0.29	0.31	0.34	0.36	0.39	0.41	0.43	0.46	0.48	0.51	0.53	0.56	0.58	0.6	0.63	0.65	0.68	0.7];
J_max = max(J);
J_min = min(J);
Cp = [0.0383	0.0386	0.0389	0.0392	0.0394	0.0396	0.0396	0.0396	0.0396	0.0394	0.0391	0.0388	0.0383	0.0376	0.0368	0.0359	0.0348	0.0336	0.0322	0.0306	0.0289	0.027	0.0248	0.0224	0.0198	0.0171	0.0142	0.0111	0.0079	0.0048];
Ct = [0.1021	0.1007	0.0992	0.0975	0.0957	0.0937	0.0915	0.0892	0.0867	0.084	0.0811	0.078	0.0748	0.0713	0.0677	0.0638	0.0599	0.0558	0.0517	0.0475	0.0431	0.0387	0.0341	0.0295	0.0247	0.0199	0.015	0.0101	0.0051	0];

pCp = polyfit(J,Cp,5);
pCt = polyfit(J,Ct,5);
D = 11*0.0254;
prop_RPM = 6000;

%% velocidades e voltagens escolhidas

V = 0:0.05:19.58;
v = (2.4:2.4:20);

%% inicialização de parametros

[~,~,~,rho] = atmosisa(1000);
nhz = (prop_RPM-1500)/60:0.01:((prop_RPM+1500)/60);
ome = 2*pi*nhz;
RPM = nhz*60;

T = zeros(1,length(V)); %armazena os valores de tração, importante notar que ele ter esse tamanho porque percorre os valores das duas linhas de V
ome1 = zeros(1,length(V)); %armazena os valores de omega em que ocorrem o regime permantente a cada velocidade

Q_dat = [0.127108125	0.128237975	0.12925484	0.13015872	0.130949615	0.131401555	0.131627525	0.131627525	0.131401555	0.13083663	0.130045735	0.1288029	0.127108125	0.12496141	0.122362755	0.119199175	0.115583655	0.11162918	0.106996795	0.101799485	0.09603725	0.089597105	0.08247905	0.074457115	0.065870255	0.05671847	0.047114745	0.03683311	0.02621252	0.01604387];
V_dat = [0	0.67056	1.34112	2.01168	2.68224	3.3528	4.068064	4.738624	5.409184	6.079744	6.750304	7.420864	8.091424	8.761984	9.432544	10.103104	10.773664	11.444224	12.159488	12.830048	13.500608	14.171168	14.841728	15.512288	16.182848	16.853408	17.523968	18.194528	18.865088	19.580352];
T_dat = [7.62424908	7.52194002	7.4062863	7.28173614	7.14828954	6.99705006	6.83691414	6.66343356	6.47660832	6.2719902	6.05847564	5.8271682	5.58696432	5.32896756	5.05317792	4.76849184	4.4704611	4.17243036	3.86105496	3.54523134	3.22051128	2.88689478	2.54883006	2.2018689	1.85045952	1.48570548	1.12095144	0.75174918	0.3780987	-0.00444822]/9.81;

Q1 = zeros(1,length(V));

%% Equações que modelam o problema

for iV = 1:length(V) %percorre cada coluna de uma linha de V
    J = V(iV)./(D.*nhz);
    Cp = polyval(pCp(:),J);
    Qp = 1/2*rho.*ome.^2*pi*(D/2)^5.*Cp;
    Qm = ((v(3) - ome./kv)./r - i0)./kv;
    [M,I] = min(abs(Qm-Qp));
    Q1(iV) = Qp(I);
    J1 = J(I);
    ome1(iV) = prop_RPM*2*pi/60;
    Ct = polyval(pCt(:),J1);
    T(iV) = 1/2*rho*ome1(iV)^2*pi*(D/2)^4*Ct/9.81; %tração em Kg de força
end

RPM1 = ome1*60/(2*pi); %valores em RPM das velocidades onde ocorre o regime permanente

hold on
plot(V,T,'DisplayName','Meus')
plot(V_dat,T_dat,'DisplayName','dados')
legend('show')
xlabel 'Velocidade (m/s)'
ylabel 'Tração (Kg)'
grid on

% %% Teste
% 
% J_teste = J_min:0.01:J_max;
% Cp_teste = polyval(pCp,J_teste);
% 
% hold on
% plot(J_teste,Cp_teste)
% plot(J,Cp)
% grid on