%teste modelamento do grupo moto-prop

clear
clc

format bank

[~,~,~, rho] = atmosisa(1000);

%% load de dados de motor e helice a serem utilizados

load('engine_data.mat');
load('prop_data.mat','pCp','pCt','prop_nome','prop_diametro');

%% escolha do motor dentre os do arquivo 'engine_data.mat'

motor = buscam(sm,'Scorpion SII-3026-890KV');
kv = kv(motor);
r = r(motor);
i0 = i0(motor);
imax = imax(motor);

clear sm

%% escolha dos parametros da helice

helice = buscam(prop_nome,'apce_11x7_kt0538_4997.txt');
helice2 = buscam(prop_nome,'apce_11x7_kt0539_4997.txt');

pCp = [pCp(helice,:) pCp(helice2,:)];
pCt = [pCt(helice,:) pCt(helice2,:)];
pCq = [pCp(1) pCp(2)]/(2*pi);
D = prop_diametro(helice)*0.0254; %o valor do diametro informado pelo fabricante deve ser convertido de polegadas para metros

clear prop_nome
clear prop_diametro

%% escolha e inicialização de parametros

V=(5:0.5:20); %Velocidades testadas em m/s
v = (2.4:2.4:20); %a escolha só pode ser feita a partir de multiplos de 2.4 volt
J = (J_min(helice):0.001:J_max(helice));
n = zeros(length(V),length(J));
n1 = zeros(length(v),length(V));
T = zeros(1,length(V)); %incializando T
i = zeros(1,length(V)); %inicializando i
eta_m = zeros(1,length(V)); %inicializando nm
eta_p = zeros(1,length(V)); %inicializando np
Cq = polyval(pCq,J); % vetor com os valores de Cq para cada valor de J calculado

%% loop que preenche as curvas de T x V, i x V e eta x V e plota em um gráfico

for l=3:(length(v)-1)
    for m=1:length(V)
        %% Equações que modelam o problema
        n(m,:) = V(m)./(J*D);
        RPM = n(m,:)*60;
        if 
        Qp = rho.*n(m,:).^2.*D.^5.*Cq;
        Qm = ((v(l) - RPM./kv)./r - i0)./kv; %os valores de kv devem ser convertidos para hz/volt e a rotação para hz
        [M,I] = min(abs(Qp-Qm)); %Depois de ter um vetor com os valores de Qp e Qm para a velocidade V(m) e ddp v(l) queremos saber qual
        M;
        clear M             %valor de n nos dará o menor valor de Qp-Qm, pois essa é a intersecção entre os graficos (ponto onde Qp=Qm)
        n1(l,m) = n(m,I);
        RPM1 = RPM(I)
        J1 = V(m)/(n1(l,m)*D);
        %recalculando J para o valor de n encontrado
        
        %% Preenchendo vetores T, i e eta
        
        T(l,m) = rho*n1(l,m)^2*D.^4.*polyval(pCt,J1); %Valor do Empuxo para o n encontrado dado V(m) do loop
        i(l,m) = (v(l)- RPM1/kv)/r; %Valor da corrente para o n encontrado dado V(m) do loop
        eta_m(l,m) = (1-i0*r/(v(l)- RPM1/kv))/(v(l)*kv); %eficiencia do motor para o n encontrado dado o V(m) do loop
        eta_p(l,m) = polyval(pCt,J1)*J1/polyval(pCp,J1); %eficiencia da helice para o n encontrado dado o V(m) do loop
        
    end
end


eta_t = eta_m.*eta_p;

%% plot T x V

subplot(1,3,1)
hold on
plot(V,T);
grid on
xlabel 'Velocidade (m/s)'
ylabel 'Tração (N)'
legend(num2str(v(4))+" volt",num2str(v(5))+" volt",num2str(v(6))+" volt",num2str(v(7))+" volt",num2str(v(8))+" volt")

%% plot i x V

subplot(1,3,2)
hold on
grid on
plot(V,i);
plot(V,imax)
xlabel 'Velocidade (m/s)'
ylabel 'i (c/s)'
legend(num2str(v(4))+" volt",num2str(v(5))+" volt",num2str(v(6))+" volt",num2str(v(7))+" volt",num2str(v(8))+" volt")

%% plot eta x V

subplot(1,3,3)
hold on
plot(V,eta_t);
grid on
xlabel 'Velocidade (m/s)'
ylabel 'eta'
legend(num2str(v(4))+" volt",num2str(v(5))+" volt",num2str(v(6))+" volt",num2str(v(7))+" volt",num2str(v(8))+" volt")


saveas(gcf,'TxV_ixV_etaxV_apce_9x4.5_SII_3026_890KV.jpg') %salva o plot gerado

% rotRPM = n*60;
