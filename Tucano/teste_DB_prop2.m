% teste DB helice

clear
clc

%% colocando parametros importantes das hélices

Tprop_name = readtable('C:\Users\daanr\Documents\Daniel\httrack\propDB\m-selig.ae.illinois.edu\props\volume-1\prop_name.txt','TextType','string','ReadVariableNames',false);
prop_marca = Tprop_name{:,1};
prop_passo_diam = split(Tprop_name{:,2},"x");
prop_diametro = str2double(prop_passo_diam(:,1));
prop_passo = str2double(prop_passo_diam(:,2));
prop_numsei = Tprop_name{:,3};
prop_RPM_txt1 = Tprop_name{:,4};
for x=1:length(prop_RPM_txt1)
    if prop_RPM_txt1(x) ~= ""
        prop_RPM_txt(x,:) = split(prop_RPM_txt1(x),".");
    else
        prop_RPM_txt(x,:) = "0";
    end
end
prop_RPM = str2double(prop_RPM_txt(:,1));

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
pCt = zeros(length(path_completo),5);
pCp = zeros(length(path_completo),5);
peta = zeros(length(path_completo),5);
J_max = zeros(1,length(path_completo));
J_min = zeros(1,length(path_completo));

%% loops que preenchem os arrays pCt pCp peta

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
                Cp = T{:,{'CT'}};
                if string(T.Properties.VariableNames{1})=="RPM"
                    Cps(n,:) = Cp;
                end
            elseif string(T.Properties.VariableNames{l})=="CP"
                Ct = T{:,{'CP'}};
                if string(T.Properties.VariableNames{1})=="RPM"
                    Cts(n,:) = Ct;
                end
            elseif string(T.Properties.VariableNames{l})=="eta"
                eta = T{:,{'eta'}};
            end
            if string(T.Properties.VariableNames{1})=="J" && string(T.Properties.VariableNames{2})=="CT" && string(T.Properties.VariableNames{3})=="CP" && string(T.Properties.VariableNames{4})=="eta" && l==colT
                pCt1 = polyfit(J,Cp,4);
                pCp1 = polyfit(J,Ct,4);
                peta1 = polyfit(J,eta,4);
                for y=1:5
                    pCt(n,y) = pCt1(y);
                    pCp(n,y) = pCp1(y);
                    peta(n,y) = peta1(y);
                end
            end
        end
    end
end

%% save dos dados

save('prop_data.mat','pCt','pCp','peta','prop_marca','prop_passo','prop_RPM','prop_diametro','J_max','J_min','prop_nome','Cts','Cps','RPMs')
