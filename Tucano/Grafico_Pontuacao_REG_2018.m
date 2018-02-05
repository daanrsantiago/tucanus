%graficos pontua��o Regulamento Micro 2019

clear 
clc

%% Inicializa��o de parametros

PV = linspace(0.1,5,500);
CP = linspace(0.1,12,500);

%% Equa��o da pontua��o

% P = Pvoo + Pac
%Pvoo = 30*FPV*FTD*(1.5*CPlapes+CPal)*(0.3/(0.4+e^-EE)+0.3)


[X,Y] = meshgrid(PV,CP);
EE = Y./X;
P_CP_PV1 = (1.5.*Y).*(0.3./(0.4 + exp(-EE))+0.3); % se a carga paga for do tipo LAPES
P_CP_PV2 = Y.*(0.3./(0.4 + exp(-EE))+0.3); % se a carga paga for do tipo alijada normalmente

%% plot dos dados

figure('Name','pontua��o x CPlapes x PV','NumberTitle','off');

mesh(X,Y,P_CP_PV1)
grid on
xlabel PV
ylabel CPlapes
zlabel Pee

figure('Name','pontua��o x CPal x PV','NumberTitle','off');

mesh(X,Y,P_CP_PV2)
grid on
xlabel PV
ylabel CPal
zlabel Pee

%% restri��es geometricas

% caixa de transporte deve possuir volume interno de no m�ximo 0,030m� e ser um
% paralelep�pedo, cujos lados devem ser ortogonais entre si, e as medidas de
% Comprimento (L), Largura (W) e Altura (H) devem corresponder �s dimens�es
% internas da caixa (Ver AP�NDICE 6)

