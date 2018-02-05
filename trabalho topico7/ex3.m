% Daniel Ribeiro Santiago 11711EAR039
% Ex2 lista topico 7

clear
clc

%% letra a

syms m g N F h x mi 

display('letra a)')
N = solve(-F*x/(x^2+h^2)^(1/2)+mi*N,N);
F = solve(-m*g+N+F*h/((x^2+h^2)^(1/2)),F);
fprintf('\r o valor de F é: %s \n \n',F)

%% letra b

display('letra b)')
S = subs(F,[m,h,g,mi],[18,10,9.81,0.55]);
fprintf('\r F em função de x é: %s \n \n',S)

%% letra c

ezplot(x,S,[5,30])
grid on
xlabel 'x[m]'
ylabel 'F[N]'

%% letra d

display('letra d)')
d = double(solve(diff(S)));
Fmin = double(subs(S,x,d));
fprintf('\r o valor da distacia de x para que F seja minimo é: %f metros \n \n',d)
fprintf('\r o valor minimo de F é: %f newtons \n \n',Fmin)