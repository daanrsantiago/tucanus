%tentativa de polyfit para Ct de uma helice

clear
clc

%% Dados

%Diametro em metros
D = 0.19812;
%Passo em metros
Pa = 0.1778;

Ct = [0.0992 0.0965	0.096 0.0947 0.0938	0.0913 0.0884 0.0845 0.0802	0.0727 0.0662 0.0579 0.0521	0.0433 0.0351 0.0273 0.02];
Cp = [0.0824 0.0796	0.0781 0.0766 0.076	0.0747 0.0747 0.0737 0.0722	0.0685 0.0653 0.0604 0.057 0.0511 0.0452 0.039 0.0338];
Cq = Cp./(2*pi);
J = [0.171 0.217 0.265 0.309 0.354 0.401 0.454 0.498 0.539 0.59 0.631 0.681	0.717 0.763	0.81 0.858 0.901];
eta = [0.206 0.263 0.326 0.381 0.437 0.491 0.537 0.571 0.599 0.626 0.639 0.652 0.655 0.647 0.631 0.602 0.535];

%% dados ajustados a polinomios

pCt = polyfit(J,Ct,3);
pCp = polyfit(J,Cp,3);
pCq = pCp/(2*pi);

YCt = polyval(pCt,J);
YCp = polyval(pCp,J);
YCq = YCp./(2*pi);

%%  Qp x n

ro = 1.2928;
n = 50:0.5:100;
V = 35;
Qp = ro.*n.^2.*D.^5.*polyval(pCq,(V./(n.*D)));

%% save

save('Helice1.mat','D','ro','pCt','pCq')

%% plot dos valores

subplot(3,1,1)
plot(J,YCt)
hold on
plot(J,Ct,'-o')
grid on
xlabel J
ylabel Ct

subplot(3,1,2)
plot(J,YCp)
hold on
plot(J,Cp,'-o')
grid on
xlabel J
ylabel Cp

subplot(3,1,3)
plot(J,YCq)
hold on
plot(J,Cq,'-o')
grid on
xlabel J
ylabel Cq

%% Grafico Qp x n

plot(n,Qp)
grid on
xlabel n
ylabel Qp 
