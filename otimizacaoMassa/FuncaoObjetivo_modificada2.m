function[result] = FuncaoObjetivo(x,y)
load('prop_data.mat','pCts','pCps','prop_nome')
load('engine_data.mat')
%% Manipulador de indices
moto = floor(x(1));
prop = floor(x(2));
numCelula = floor(x(3));

tolerancia = .20;

%% Parâmetros das helices APC - Elétricas
diam(1) = 10;%10x5
cpo(1,:) = pCps(buscam(prop_nome,'apce_10x5_static_pg0819.txt'),:);
cto(1,:) = pCts(buscam(prop_nome,'apce_10x5_static_pg0819.txt'),:);
massaProp(1) = 21.15;
sp{1} = 'APC 10x5';

diam(2) = 10;%10x7
cpo(2,:) = pCps(buscam(prop_nome,'apce_10x7_static_pg0811.txt'),:);
cto(2,:) = pCts(buscam(prop_nome,'apce_10x7_static_pg0811.txt'),:);
massaProp(2) = 21.15;
sp{2} = 'APC 10x7';

diam(3) = 11;%11x5.5
cpo(3,:) = pCps(buscam(prop_nome,'apce_11x5.5_static_kt0467.txt'),:);
cto(3,:) = pCts(buscam(prop_nome,'apce_11x5.5_static_kt0467.txt'),:);
massaProp(3) = 21.83;
sp{3} = 'APC 11x5.5';

diam(4) = 11;% 11x7
cpo(4,:) = pCps(buscam(prop_nome,'apce_11x7_static_kt0534.txt'),:);
cto(4,:) = pCts(buscam(prop_nome,'apce_11x7_static_kt0534.txt'),:);
massaProp(4) = 21.83;
sp{4} = 'APC 11x7';

diam(5) = 11;% 11x8
cpo(5,:) = pCps(buscam(prop_nome,'apce_11x8_static_kt0517.txt'),:);
cto(5,:) = pCts(buscam(prop_nome,'apce_11x8_static_kt0517.txt'),:);
massaProp(5) = 21.83;
sp{5} = 'APC 11x8';

diam(6) = 10;% Master eletrica 10x7
cpo(6,:) = pCps(buscam(prop_nome,'mae_10x7_static_jb0754.txt'),:);
cto(6,:) = pCts(buscam(prop_nome,'mae_10x7_static_jb0754.txt'),:);
massaProp(6) = 21.15;
sp{6} = 'Master E 10x7';

diam(7) = 11;% Master eletrica 11x7
cpo(7,:) = pCps(buscam(prop_nome,'mae_11x7_static_rd0577.txt'),:);
cto(7,:) = pCts(buscam(prop_nome,'mae_11x7_static_rd0577.txt'),:);
massaProp(7) = 21.83;
sp{7} = 'Master E 11x7';

diam(8) = 11;%% Master G/F 11x5
cpo(8,:) = pCps(buscam(prop_nome,'magf_11x5_static_3027tg.txt'),:);
cto(8,:) = pCts(buscam(prop_nome,'magf_11x5_static_3027tg.txt'),:);
massaProp(8) = 21.83;
sp{8} = 'Master G/F 11x5';

diam(9) = 11;%% Master G/F 11x8
cpo(9,:) = pCps(buscam(prop_nome,'magf_11x8_static_3033tg.txt'),:);
cto(9,:) = pCts(buscam(prop_nome,'magf_11x8_static_3033tg.txt'),:);
massaProp(9) = 21.83;
sp{9} = 'Master G/F 11x8';

diam(10) = 10;%% APC sf 10x7
cpo(10,:) = pCps(buscam(prop_nome,'apcsf_10x7_static_kt0827.txt'),:);
cto(10,:) = pCts(buscam(prop_nome,'apcsf_10x7_static_kt0827.txt'),:);
massaProp(10) = 20;
sp{10} = 'APC sf 10x7';

diam(11) = 11;%% APC sf 11x3.8
cpo(11,:) = pCps(buscam(prop_nome,'apcsf_11x3.8_static_kt0542.txt'),:);
cto(11,:) = pCts(buscam(prop_nome,'apcsf_11x3.8_static_kt0542.txt'),:);
massaProp(11) = 21.83;
sp{11} = 'APC sf 11x3.8';

diam(12) = 11;%% APC sf 11x4.7
cpo(12,:) = pCps(buscam(prop_nome,'apcsf_11x4.7_static_pg0526.txt'),:);
cto(12,:) = pCts(buscam(prop_nome,'apcsf_11x4.7_static_pg0526.txt'),:);
massaProp(12) = 21.83;
sp{12} = 'APC sf 11x4.7';

diam(13) = 9;%% APC 9x7.5
cpo(13,:) = pCps(buscam(prop_nome,'apce_9x7.5_static_2545rd.txt'),:);
cto(13,:) = pCts(buscam(prop_nome,'apce_9x7.5_static_2545rd.txt'),:);
massaProp(13) = 18;
sp{13} = 'APC 9x7.5';

diam(14) = 9;%% APC 9x9
cpo(14,:) = pCps(buscam(prop_nome,'apce_9x9_static_2492rd.txt'),:);
cto(14,:) = pCts(buscam(prop_nome,'apce_9x9_static_2492rd.txt'),:);
massaProp(14) = 18;
sp{14} = 'APC 9x9';

% diam(10) = ;
% cpo(10) = ;
% cto(10) = ;
% massaProp(10) = ;

%% Parametros das células de bateria
massaCelula = 40;% para A123 %% 70;
voltCelula = 2.4;

v = numCelula * voltCelula;
%% Cálculo de Torque e Rotacao
n = linspace(0, 20000, 5000); %% rpm
Q = (((v-n/kv(moto))/r(moto))-i0(moto))/(2*pi*kv(moto)/60);

%limites de operacao
aux = find(Q<=0,1); %ponto inferior da curva
i = (v-(n/kv(moto)))/r(moto); %calculo da curva de corrente
aux2 = find(i<=imax(moto),1); %ponto máximo da curva

%% Atmosfera
roh = 1.134; % 1.058;%% DENSIDADE do ar deve ir de 1,112 ate 1,0582


%% Calculo da Hélice
Qh = (roh * (n/60).^2 * (diam(prop)*0.0254)^5 .* polyval(cpo(prop,:),n/60));

% plot(n(aux2:aux), Q(aux2:aux), n, Qh)
% axis([000 13000 0 5]);

index = find( Q-Qh <= 0.01, 1);
nbase = n(index);

tracao = roh .* (nbase/60).^2 .* (diam(prop)*0.0254).^4 .* polyval(cto(prop,:),nbase);% tracao em N

massaTotal = massaCelula*numCelula + massa(moto) + massaProp(prop);

while(i(index) > (1+tolerancia)*imax(moto))
    %%Redefinicao de parametros
    x(3) = x(3) - 1;
    numCelula = floor(x(3));
    
    v = numCelula * voltCelula;
    %% Cálculo de Torque e Rotacao
    Q = (((v-n/kv(moto))/r(moto))-i0(moto))/(2*pi*kv(moto)/60);
    %% Limites de operacao
    aux = find(Q<=0,1); %ponto inferior da curva
    i = (v-(n/kv(moto)))/r(moto); %calculo da curva de corrente
    aux2 = find(i<=imax(moto),1); %ponto máximo da curva

    %% Calculo da Hélice
    Qh = (roh .* (n/60).^2 * (diam(prop)*0.0254).^5 .* polyval(cpo(prop,:),n/60));

    plot(n(aux2:aux), Q(aux2:aux), n, Qh)
    axis([000 13000 0 5]);

    index = find( Q-Qh <= 0.01, 1);
    nbase = n(index);

    tracao = roh .* (nbase/60).^2 .* (diam(prop).*0.0254).^4 .* polyval(cto(prop,:),nbase);% tracao em N

    
end
    plot(n(aux2:aux), Q(aux2:aux), n, Qh)
    axis([0 18000 0 5]);
    dim = [0.2 0.5 0.3 0.3];
    str = {sm{moto},sp{prop},strcat( num2str(numCelula), ' Células')};
    annotation('textbox',dim,'String',str,'FitBoxToText','on');
    xlabel('Rotação [RPM]')
    ylabel('Torque [lbf.in]')
    title('Curva Torque x Rotação')
    grid minor
    pause(.005)
    clf
    massaTotal = massaCelula*numCelula + massa(moto) + massaProp(prop);
    fprintf('Conjunto: %d - %d - %d\n->tracao %5.2f\n->rotacao %5.2f\n->massa %4.2f\n->tensão %3.2f\n->corrente %4.2f\n',moto, prop, numCelula, tracao, n(index), massaTotal, v, i(index));
    fprintf('Razao %3.5f\n\n', tracao/massaTotal);
    
  
result = -(tracao/massaTotal); %%retora valor mínimo

if isempty(result)
   keyboard 
end
    
end

