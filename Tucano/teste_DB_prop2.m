% Esse codigo pega os dados das hélices do banco de dados da universidade
% de linois e os armazena em um arquivo .mat alem de armazenar os
% polinomios que geram os graficos desse dados

clear
clc

%% colocando parametros importantes das hélices

Tprop_name = readtable('C:\Users\daanr\Documents\Daniel\httrack\propDB\m-selig.ae.illinois.edu\props\volume-1\prop_name.txt','TextType','string','ReadVariableNames',false);
prop_marca = Tprop_name{:,1}; % salva a marca da hélice
prop_passo_diam = split(Tprop_name{:,2},"x");  % essa variavel pega um texto do tipo "12x5.5", onde 12 seria o diametro e 5.5 o passo, e o divide em "12" e "5.5"
prop_diametro = str2double(prop_passo_diam(:,1)); % salva o diametro da hélice em polegadas
prop_passo = str2double(prop_passo_diam(:,2)); % salva o passo em polegadas
prop_numsei = Tprop_name{:,3}; %esse aqui é um numero aleatorio que fica no nome dos arquivos
prop_RPM_txt1 = Tprop_name{:,4}; % essa variavel pega o nome do arquivo que tem o algo do tipo "1212.txt" onde esse 1212 é um exemplo de rotação em RPM
for x=1:length(prop_RPM_txt1) % esse loop separa o "1212.txt" em "1212" e "txt" por exemplo
    if prop_RPM_txt1(x) ~= ""
        prop_RPM_txt(x,:) = split(prop_RPM_txt1(x),".");
    else
        prop_RPM_txt(x,:) = "0";
    end
end
prop_RPM = str2double(prop_RPM_txt(:,1)); % agora é salva a  parte da variavel que interessa, que é a rotação em RPM, o resto é descartado

clear Tprop_name prop_RPM_txt1 prop_RPM_txt

%% preenchendo array com path completo

load('prop_nome_txt.mat')
path_inicio = "C:\Users\daanr\Documents\Daniel\httrack\propDB\m-selig.ae.illinois.edu\props\volume-1\data\";
path_completo = strcat(path_inicio,propname);
prop_nome = propname;
clear propname
clear path_inicio

%% inicializando os arrays que vão guardar os coeficientes dos polinômios

Cps = zeros(length(path_completo),16);
Cts = zeros(length(path_completo),16);
RPMs = zeros(length(path_completo),16);
pCts = zeros(length(path_completo),2);
pCps = zeros(length(path_completo),2);
pCt = zeros(length(path_completo),3);
pCp = zeros(length(path_completo),3);
peta = zeros(length(path_completo),3);
J_max = zeros(1,length(path_completo));
J_min = zeros(1,length(path_completo));

%% loops que preenchem os arrays pCt pCp peta RPMs Cts Cps

for n=1:length(path_completo)
    T = readtable(path_completo(n));
    [linT,colT] = size(T);
    for k=1:linT
        for l=1:colT
            if string(T.Properties.VariableNames{l})=="J"
                J = T{:,{'J'}};
                J_max(n) = max(J);
                J_min(n) = min(J);
            elseif string(T.Properties.VariableNames{l})=="RPM"
                RPMs(n,:) = T{:,{'RPM'}};
            elseif string(T.Properties.VariableNames{l})=="CT"
                Ct = T{:,{'CT'}};
                if string(T.Properties.VariableNames{1})=="RPM"
                    Cts(n,:) = Ct;
                end
            elseif string(T.Properties.VariableNames{l})=="CP"
                Cp = T{:,{'CP'}};
                if string(T.Properties.VariableNames{1})=="RPM"
                    Cps(n,:) = Cp;
                end
            elseif string(T.Properties.VariableNames{l})=="eta"
                eta = T{:,{'eta'}};
            end
            if string(T.Properties.VariableNames{1})=="J" && string(T.Properties.VariableNames{2})=="CT" && string(T.Properties.VariableNames{3})=="CP" && string(T.Properties.VariableNames{4})=="eta" && l==colT
                pCt1 = polyfit(J,Cp,2); %armazena os polinomios para o caso dinamico
                pCp1 = polyfit(J,Ct,2);
                peta1 = polyfit(J,eta,2);
                for y=1:3
                    pCt(n,y) = pCt1(y);
                    pCp(n,y) = pCp1(y);
                    peta(n,y) = peta1(y);
                end
            end
            if string(T.Properties.VariableNames{1})=="RPM" %armazena os polinomios para o caso estatico
                pCts1 = polyfit(RPMs(n,:),Cts(n,:),1);
                pCps1 = polyfit(RPMs(n,:),Cps(n,:),1);
                for y=1:2
                    pCts(n,y) = pCts1(y);
                    pCps(n,y) = pCps1(y);
                end
            end
        end
    end
end

%% save dos dados

save('prop_data.mat','pCt','pCp','peta','prop_marca','prop_passo','prop_RPM','prop_diametro','J_max','J_min','prop_nome','Cts','Cps','RPMs','pCts','pCps')
