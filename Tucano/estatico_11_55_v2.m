clear
clc

load('engine_data.mat') % carrega o banco de dados de motores

global RPMs_apc Cps_apc Cts_apc

%% escolha do motor

% retira do banco de dados de motores os parametros do motor ecolhido (kv,
% r, io e imax)

% o "buscam" vem de busca motor. Ele consegue achar o indice do motor no
% banco de dados tendo como input o nome dele

motor = buscam(sm,'Scorpion SII-3026-890KV');
kv = kv(motor)*2*pi/60;
r = r(motor);
i0 = i0(motor);
imax = imax(motor);

clear sm

%% h�lice

% � feito um polyfit para obter valores de Cp e Ct estaticos "discretos",
% ou seja para rota��es entre os valores dados no vetor RPMs

pCps(1) = polyfit(RPMs_apc.prop,Cps,1);
pCts(1) = polyfit(RPMs(3:length(RPMs)),Cts(3:length(Cts)),1); % s�o pegos os pontos ap�s o terceiro para ter uma tend�ncia de reta mais plausivel
pCqs(1) = pCps/(2*pi);

% a partir daqui s�o armazenados os dados de Cp e Ct para o caso dinamico.
% Os dados aqui s�o tirados do site da apc e s�o especificos para a rota��o
% de 12000 RPM, onde ocorre o regime permanente no caso estatico com esse
% grupo moto-prop

J = [0  0.02	0.05	0.07	0.1	0.12	0.14	0.17	0.19	0.22	0.24	0.27	0.29	0.31	0.34	0.36	0.39	0.41	0.43	0.46	0.48	0.51	0.53	0.55	0.58	0.6	0.63	0.65	0.67	0.7];
Ct = [0.1085    0.1071	0.1055	0.1036	0.1016	0.0994	0.097	0.0944	0.0916	0.0886	0.0854	0.082	0.0785	0.0747	0.0708	0.0668	0.0626	0.0584	0.0541	0.0497	0.0451	0.0405	0.0357	0.0309	0.0259	0.0208	0.0158	0.0106	0.0053	0];
Cp = [0.0552    0.0528	0.0506	0.0488	0.0474	0.0461	0.045	0.0439	0.0428	0.0418	0.0408	0.0398	0.0388	0.0378	0.0367	0.0355	0.0343	0.0329	0.0313	0.0296	0.0278	0.0258	0.0236	0.0212	0.0186	0.016	0.0131	0.01	0.0069	0.0039];

[J_max,~] = max(J);
[J_min,~] = min(J);

pCt = polyfit(J,Ct,5);
pCp = polyfit(J,Cp,2);
pCq = pCp/(2*pi);

D = 11*0.0254;

%% Ecolha da Voltagem e velocidade

v = 2.4:2.4:20; % o v min�sculo � para os valores de voltagem
V = 0.1:0.1:25; % o V mai�sculo � para os valores de velocidade

%% Inicializa��o de variaveis

% inicializar os vetores com zeros ajuda a dar velocidade aos loops, ja que
% os vetores n�o mudam de tamanho a cada intera��o

rho = 1.053;
T = zeros(1,length(V));
J = zeros(1,length(V));

%% Est�tico

% essa sec��o do c�digo � dedicada a encontrar a rota��o do grupo motoprop
% no caso estatico e calcular a sua tra��o nesse regime

RPM = 1600:1:13000; % Rota��es analizadas e seus equivalentes em rad/s (ome) e em hz (nhz)
ome = RPM*2*pi/60;
nhz = RPM/60;

Qm = ((v(6) - ome./kv)./r - i0)./kv; % Qm � o vetor que armazena os valores de Torque do motor para cada rota��o do vetor ome
Qps = rho*nhz.^2*D^5.*polyval(pCqs,RPM); % Qp � o vetor que armazena os valores de Torque da h�lice para cada rota��o correspondente do vetor nhz
[M,I] = min(abs(Qm-Qps)); % I � o indice do vetor RPM que armazena o ponto de intersec��o das curvas de Qm e Qp

RPM = RPM(I); % agora o vetor RPM armazena apenas o valor da rota��o no regime permanente do estatico
nhz = RPM/60;
ome = nhz*2*pi;

Ts = rho*nhz^2*D^4*0.1085/9.81; % Ts � a tra��o no estatico

%% Variando a velocidade

% nesse loop a cada valor de velocidade do vetor "V" � calculada a raz�o de
% avan�o e caso ela chegue a valores que s�o maiores que J_max ou menores que J_min 
% a tra��o � calculada pelo polinomio ao invez dos dados "puros" do
% fabricante

% caso a raz�o de avan�o esteja entre os valores de J_min e J_max ent�o s�o
% usados apenas os dados que est�o no documento do fabricante

% for I_V = 1:length(V)
%     J(I_V) = V(I_V)/(nhz*D);
%     if J(I_V) >= J_max
%         Ct = polyval(pCt,J_max);
%     else
%         Ct = polyval(pCt,J(I_V));
%     end
%     T(I_V) = rho*nhz^2*D^4*Ct/9.81;
% end
% 
% % plota os resultados da curva de tra��o
% 
% plot(V,T)
% grid minor
% xlabel 'Velocidade [m/s]'
% ylabel 'Tra��o [kg]'