
clear
clc

load('engine_data.mat')
load('prop_data.mat','Cps','Cts','RPMs','prop_nome','prop_diametro')

[~,~,~, rho] = atmosisa(1000);

%% dados motor

motor = buscam(sm,'Scorpion SII-3026-890KV');
kv = kv(motor)*2*pi/60;
r = r(motor);
i0 = i0(motor);
imax = imax(motor);
v = (2.4:2.4:20);

%% dados helice

helice = buscam(prop_nome,'apce_11x7_static_kt0534.txt');
Cp = Cps(helice,:);
Ct = Cts(helice,:);
Cq = Cp/(2*pi);
RPM = RPMs(helice,:);
D = prop_diametro(helice)*0.0254; %o valor do diametro informado pelo fabricante deve ser convertido de polegadas para metros

clear prop_diametro Cps Cts 

%% modelamento

nhz = RPM/60; %conversão da velocidade de rotação para hz
ome = nhz*2*pi;
Qm = ((v(4) - ome/kv)/r - i0)/kv; %Kv foi mantido em RPM/volt para que fosse usado RPM
Qp = 1/2*rho.*ome.^2*pi*(D/2)^5.*Cp;
[M,I] = min(abs(Qm-Qp));
M
nhz1 = nhz(I);
T = 1/2*rho*ome(I)^2*pi*(D/2)^4*Ct(I);

plot(RPM,Qm,'DisplayName','Qm')
hold on
grid on
plot(RPM,Qp,'DisplayName','Qp')
xlabel 'rotações (RPM)'
ylabel 'Q (N/m)'
legend('show')



