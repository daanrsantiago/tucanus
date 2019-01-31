% Algoritmo para calculo da densidade e altitude densidade

%% site para verificar as condições climáticas
% http://www.aviador.es/Weather/Meteogram/SBUL
% http://www.aviador.es/Weather/Meteogram/SBSJ

%% 
clear all;
close all;
clc;
% oi
%% Parâmetros iniciais

P = 916 * 100; % pressao pascoal
% P = 8.79e+4;
% T = (71.40-32)*5/9 + 273.15; % temperatura kelvin
% T = 23.8 + 273.15; % temperatura kelvin
T = 30 + 273.15;

R = 287; % constante

%% Calculo

rho = P/(R*T);

alt		= 0;
rho2	= 2;

while rho2 > rho
	alt = alt + 1;
	[~,~,~,rho2] = atmosisa(alt);
end
AD = alt;

% AD = fzero(@(x)fun(x,rho2),alt);

% plot(rho,alt)
% AD = -2468*rho^3 + 1.128e+04*rho^2 - 2.509e+04*rho + 1.834e+04; % aproximação para a curva AD x rho

%% disp
disp('rho')
disp(rho)
disp('AD')
disp(AD)

%863
%27.91 in Hg
%69.7 F