%teste modelamento Motor Scorpion SII-4035-450KV

clear
clc

%% Dados

%Kv = 450 RPM/volt. Kv = 47.1239 (rad/s)/volt. Kv = 7.5 hz/volt
Kv = 7.5;
I0 = 1.71;
R = 0.026;
W = 0.435;
Imax = 80;

%% Qm Ps Nm

ome = [500:0.5:1000];
v = [2.4:2.4:30];

Qm1 = ((v(4)-ome./(2*pi*Kv)).*1/R-I0).*1./Kv;
Qm2 = ((v(5)-ome./(2*pi*Kv)).*1/R-I0).*1./Kv;
Qm3 = ((v(6)-ome./(2*pi*Kv)).*1/R-I0).*1./Kv;

Ps1 = ((v(1)-ome./Kv).*1/R-I0).*ome./Kv;
Nm1 = (1-(I0.*R)./(v(1)-ome./Kv)).*ome./(v(1).*Kv);

%% save

save('Motor1.mat','Kv','I0','R','W','Imax','v')

%% Plot

hold on
plot(ome,Qm1)
plot(ome,Qm2)
plot(ome,Qm3)
grid on
xlabel Omega
ylabel Qm
