function[result] = FuncaoObjetivo(x,y)
load('prop_data.mat','pCts','pCps','prop_nome')

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

%% Parametros dos motores
kv(1) = 2000; %% 2203/40
i0(1) = 0.5;
r(1) = 0.245;
imax(1) = 9;
massa(1) = 17.5;% gramas
sm{1} = 'AXI 2203/40';

kv(2) = 1820; %% 2208/20
i0(2) = 0.8;
r(2) = 0.089;
imax(2) = 16;
massa(2) = 45;% gramas
sm{2} = 'AXI 2208/20';

kv(3) = 1420; %% 2208/26
i0(3) = 0.6;
r(3) = 0.155;
imax(3) = 11;
massa(3) = 45;
sm{3} = 'AXI 2208/26';

kv(4) = 1100;%% 2208/34
i0(4) = 0.35;
r(4) = .26;
imax(4) = 8;
massa(4) = 45;
sm{4} = 'AXI 2208/34';

kv(5) = 1950; %% 2212/12
i0(5) = 1.2;
r(5) = .045;
imax(5) = 28;
massa(5) = 57;
sm{5} = 'AXI 2212/12';

kv(6) = 1150;%% 2212-20
i0(6) = 0.7;
r(6) = .135;
imax(6) = 16;
massa(6) = 57;
sm{6} = 'AXI 2212/20';

kv(7) = 920;%% 2212-26
i0(7) = .45;
r(7) = .21;
imax(7) = 12;
massa(7) = 57;
sm{7} = 'AXI 2212/26';

kv(8) = 710;%% 2212-34
i0(8) = .4;
r(8) = .345;
imax(8) = 10;
massa(8) = 57;
sm{8} = 'AXI 2212/34';

kv(9) = 1380;%% 2217-12
i0(9) = .4;
r(9) = .061;
imax(9) = 30;
massa(9) = 69.5;
sm{9} = 'AXI 2217/12';

kv(10) = 1050;%% 2217-16
i0(10) = 0.4;
r(10) = .120;
imax(10) = 22;
massa(10) = 69.5;
sm{10} = 'AXI 2217/16';

kv(11) = 840;%% 2217-20
i0(11) = 0.4;
r(11) = .185;
imax(11) = 18;
massa(11) = 69.5;
sm{11} = 'AXI 2217/20';

kv(12) = 1820;%% 2208-16
i0(12) = 2;
r(12) = .075;
imax(12) = 25;
massa(12) = 76;
sm{12} = 'AXI 2208/16';

kv(13) = 1490;% 2208-20
i0(13) = 1.3;
r(13) = .105;
imax(13) = 22;
massa(13) = 76;
sm{13} = 'AXI 2208/20';

kv(14) = 1190;%% 2208-24
i0(14) = 1;
r(14) = .115;
imax(14) = 22;
massa(14) = 76;
sm{14} = 'AXI 2208/24';

kv(15) = 2850;%% 2214-6D
i0(15) = 4.5;
r(15) = .022;
imax(15) = 55;
massa(15) = 106;
sm{15} = 'AXI 2214/6D';

kv(16) = 1640;% 2814-10
i0(16) = 2.3;
r(16) = .037;
imax(16) = 45;
massa(16) = 106;
sm{16} = 'AXI 2814/10';

kv(17) = 1390;%% 2814-12
i0(17) = 1.8;
r(17) = .053;
imax(17) = 35;
massa(17) = 106;
sm{17} = 'AXI 2814/12';

kv(18) = 1035;%% 2814-16
i0(18) = 1;
r(18) = .085;
imax(18) = 30;
massa(18) = 106;
sm{18} = 'AXI 2814/16';

kv(19) = 840;%% 2814-20
i0(19) = 0.7;
r(19) = 0.145;
imax(19) = 25;
massa(19) = 106;
sm{19} = 'AXI 2814/20';

kv(20) = 1500;%% 2820-8
i0(20) = 3.3;
r(20) = 0.026;
imax(20) = 55;
massa(20) = 151;
sm{20} = 'AXI 2820/8';

kv(21) = 1200;%% 2820-10
i0(21) = 2.3;
r(21) = 0.039;
imax(21) = 42;
massa(21) = 151;
sm{21} = 'AXI 2820/10';

kv(22) = 990;%% 2820-12
i0(22) = 1.7;
r(22) = 0.059;
imax(22) = 37;
massa(22) = 151;
sm{22} = 'AXI 2820/12';

kv(23) = 860;%% 2820-14
i0(23) = 1.7;
r(23) = 0.078;
imax(23) = 36;
massa(23) = 151;
sm{23} = 'AXI 2820/14';

kv(24) = 1500;%% 2826-6
i0(24) = 3.5;
r(24) = 0.025;
imax(24) = 65;
massa(24) = 181;
sm{24} = 'AXI 2826/6';

kv(25) = 1130;%% 2826-8
i0(25) = 2.9;
r(25) = 0.030;
imax(25) = 55;
massa(25) = 181;
sm{25} = 'AXI 2826/8';

kv(26) = 920;%% 2826-10
i0(26) = 1.7;
r(26) = 0.042;
imax(26) = 42;
massa(26) = 181;
sm{26} = 'AXI 2826/10';

kv(27) = 760;%% 2826-12
i0(27) = 1.3;
r(27) = 0.062;
imax(27) = 37;
massa(27) = 181;
sm{27} = 'AXI 2826/12';

kv(28) = 660;%% 4120-14
i0(28) = 2;
r(28) = 0.041;
imax(28) = 55;
massa(28) = 320;
sm{28} = 'AXI 4120/14';

kv(29) = 515;%% 4120-18
i0(29) = 1.5;
r(29) = 0.07;
imax(29) = 55;
massa(29) = 320;
sm{29} = 'AXI 4120/18';

kv(30) = 465;%% 4120-20
i0(30) = 1.5;
r(30) = 0.082;
imax(30) = 52;
massa(30) = 320;
sm{30} = 'AXI 4120/20';

kv(31) = 385;%% 4130-16
i0(31) = 1.3;
r(31) = 0.063;
imax(31) = 60;
massa(31) = 409;
sm{31} = 'AXI 4130/16';

kv(32) = 305;%% 4130-20
i0(32) = 1.2;
r(32) = 0.099;
imax(32) = 55;
massa(32) = 409;
sm{32} = 'AXI 4130/20';

% kv(1) = ;
% i0(1) = ;
% r(1) = ;
% imax(1) = ;
% massa(1) = ;


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
    Q = 8.85075*60*(((v-(n/kv(moto)))/r(moto))-i0(moto))/(2*pi*kv(moto));
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
    
end

