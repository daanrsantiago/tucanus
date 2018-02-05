%codigo corrida de decolagem
clear
clc

%% Abre os aquivos .fig e salva seus dados

Curva_tracao = openfig('Moto-propulsor\curvatracao_1.fig','Invisible'); %#ok<*NASGU>
D_tracao = get(gca,'Children');
V_tracao = get(D_tracao,'XData');
T_tracao = get(D_tracao,'YData');

Curva_CLmax = openfig('Asa\Clmax_1.fig','Invisible'); 
D_CLmax = get(gca,'Children');
Re_CLmax = get(D_CLmax,'XData');
Clmax_CLmax = get(D_CLmax,'YData');

Curva_CLincidencia = openfig('Asa\cl_1.fig','Invisible'); 
D_CLincidencia = get(gca,'Children');
Re_CLincidencia = get(D_CLincidencia,'XData');
Cl_CLincidencia = get(D_CLincidencia,'YData');

Curva_CD = openfig('Asa\Cd_1.fig','Invisible');
D_CD = get(gca,'Children');
Re_CD = get(D_CD,'XData');
Cd_CD = get(D_CD,'YData');

clear Curva_tracao Curva_CLmax Curva_CLincidencia Curva_CD D_tracao D_CLmax D_CLincidencia D_CD

%% Parametros da aeronave

A_ref = 0.680; % Area de referencia da asa em m^2
c_med_aer = 0.36; % Corda media aerodinamica em m
M_motoprop = 0.658; % Massa do grupo Moto-propulsor em Kg
rho = 1.1118; % Densidade do ar em Kg/m^3
g = 9.8066; % Acelera��o da gravidade em m/s^2
ni =  1.5824e-05; % Viscosidade cinematica do ar em m^2/s 
M_aeron = 2; % Massa da aeronave sem o grupo Moto-Propulsor em Kg
V_aprox = 14; % Velocidade de aproxima��o em m/s
TOW = 18; % peso de decolagem em Kg
mi_atr_cin = 0.06; % Coeficiente de atrito cinetico dos rolamentos das rodas

%% C�lculo da dist�ncia de rolagem (Sg)

W = TOW*g; % For�a peso da aeronave
t = 0; % Inicializando a variavel de tempo em 0 segundos
dt = 0.001; %varia��o do tempo por intera��o
V = 0; % Inicializa��o da velocidade incial na corrida de decolagem
S = 0; % Inicializa��o da posi��o incial da corrida de decolagem
L = 0; % Inicializa��o da for�a de sustenta��o na corrida de decolagem

while W > L
    Re = V*c_med_aer/ni; % Nuemro de reynolds a cada intera��o
    [~,I_Cl] = min(abs(Re_CLincidencia-Re)); % Salva o indice do numero de reynolds mais proximo que temos na curva de Clxreynolds
    [~,I_Cd] = min(abs(Re_CD-Re));
    [~,I_T] = min(abs(V_tracao-V));
    Fat = mi_atr_cin*(W-L); %For�a de atrito a cada intera��o
    D = rho*A_ref*V^2*Cd_CD(I_Cd); %For�a de Arrasto a cada intera��o
    T = T_tracao(I_T); %For�a de tra��o a cada intera��o
    if S >= 50
        L = rho*A_ref*V^2*Clmax_CLmax(I_Cl);
    else
        L = rho*A_ref*V^2*Cl_CLincidencia(I_Cl); % For�a de sustenta��o a cada intera��o
    end
    a = (T-D-Fat)/TOW;
    V = V + a*dt;
    S = S + V*dt;
    t = t + dt;
end
S


