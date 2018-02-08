% codigo que me da dimensões possiveis para teste de carregaemento de carga

clear
clc

%% vetores com as possiveis dimensões de cada parte da aeronave

% ASA

asa_l = linspace(160,200,20);
asa_c = linspace(20,30,20);
asa_h = 0.13*asa_c;

% BOOM

boom_l = linspace(40,60,20);
boom_c = linspace(1,3,20);
boom_h = linspace(1,3,20);

% EMPENAGEM HORIZONTAL

eh_l = linspace(35,45,20);
eh_c = linspace(8,12,20);
eh_h = 0.13*eh_c;

% EMPENAGEM VERTICAL

ev_l = linspace(17,23,20);
ev_c = linspace(8,12,20);
ev_h = 0.15*ev_c;

% FUSELAGEM

fus_l = linspace(55,65,20);
fus_c = linspace(15,17,20);
fus_h = linspace(11,13,20);

% CONTROLE

V_cont = 25*19*9; %ml

% RODA 1

V_roda1 = 2*(10*10*0.7); %ml

% RODA 2

V_roda2 = 9.5*9.5*0.7; %ml

% BATERIA

V_bat = 10.5*3.5*2; %ml

%% Calculo e armazenamento das possiveis dimensões que caibam em uma caixa de 30 litros (3000ml)

i = 1;

for n = 1:100
    % Volume de uma asa aleatoria
    asa_ale = [asa_l(randi([1 20])),asa_c(randi([1 20])),asa_h(randi([1 20]))];
    V_asa = asa_ale(1)*asa_ale(2)*asa_ale(3);
    % Volume de um Boom aleatorio
    boom_ale = [boom_l(randi([1 20])),boom_c(randi([1 20])),boom_h(randi([1 20]))];
    V_boom = boom_ale(1)*boom_ale(2)*boom_ale(3);
    % Volume de uma EH aleatoria
    eh_ale = [eh_l(randi([1 20])),eh_c(randi([1 20])),eh_h(randi([1 20]))];
    V_eh = eh_ale(1)*eh_ale(2)*eh_ale(3);
    % Volume de uma EV aleatoria
    ev_ale = [ev_l(randi([1 20])),ev_c(randi([1 20])),ev_h(randi([1 20]))];
    V_ev = ev_ale(1)*ev_ale(2)*ev_ale(3);
    % Volume de uma fuselagem aleatoria
    fus_ale = [fus_l(randi([1 20])),fus_c(randi([1 20])),fus_h(randi([1 20]))];
    V_fus = fus_ale(1)*fus_ale(2)*fus_ale(3);
    
    % Soma dos volumes
    
    Soma = V_asa+V_boom+V_eh+V_ev+V_fus+V_roda1+V_roda2+3*V_bat;
    
    if Soma <= 28000
        asa(i,:) = asa_ale;
        boom(i,:) = boom_ale;
        eh(i,:) = eh_ale;
        ev(i,:) = ev_ale;
        fus(i,:) = fus_ale;
        Soma_1(i) = Soma;
        Soma
        dim_aeronave(:,:,i) = {asa(i,:);boom(i,:);eh(i,:);ev(i,:);fus(i,:)};
        i = i+1;
    end
end
        
        
        