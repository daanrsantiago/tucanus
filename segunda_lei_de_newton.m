%programa fisica experimental relatorio segunda lei de newton
clc;clear;

t= [1.2778 1.2747 1.2683 ; 1.3136 1.3096 1.2994 ; 1.3646 1.3558 1.3570 ; 1.4047 1.3990 1.4105 ; 1.4377 1.4468 1.4453];

T = t.';
Mediat = mean(T);

Massa = 1./(0.2035+0.0065+0.010+[0.020:0.020:0.100]);

d = 0.51;

a = 2.*d./(Mediat.^2);

%% coeficientes da regressão linear

coeficientes = polyfit(Massa,a,1)

%% coeficientes da reta da regressão
x = 0:0.01:10;
y = polyval(coeficientes,x);

%% calculando o coeficiente de determinação

r = (coeficientes(1)*std(Massa,0,2)/std(a,0,2))^2

%% plot da reta da regressão
plot(Massa,a,'o',x,y)
grid on
axis([2 6 0.2 0.8])
xlabel 'Massa (kg)'
ylabel 'Aceleração (m/s²)'