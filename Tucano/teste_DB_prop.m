% teste DB helice

clear
clc

Tprop_name = readtable('C:\Users\daanr\Documents\Daniel\httrack\propDB\m-selig.ae.illinois.edu\props\volume-1\prop_name.txt','TextType','string');
prop_marca = Tprop_name{:,1};
prop_passo = Tprop_name{:,2};
prop_numsei = Tprop_name{:,3};
prop_RPM = Tprop_name{:,4};
clear Tprop_name
load('prop_nome_txt.mat')
path_inicio = "C:\Users\daanr\Documents\Daniel\httrack\propDB\m-selig.ae.illinois.edu\props\volume-1\data\";
path_completo = strcat(path_inicio,propname);

Cp = zeros(20,1114);
Ct = zeros(20,1114);
eta = zeros(20,1114);
J =  zeros(20,1114);

for n=2:length(propname)
T = readtable(path_completo(n));
[linT,colT] = size(T);
for k=1:linT
    for l=1:colT
        if string(T.Properties.VariableNames{l})=="CP"
            Cp(k,n-1) = T{k,{'CP'}};
        elseif string(T.Properties.VariableNames{l})=="CT"
            Ct(k,n-1) = T{k,{'CT'}};
        elseif string(T.Properties.VariableNames{l})=="eta"
            eta(k,n-1) = T{k,{'eta'}};
        elseif string(T.Properties.VariableNames{l})=="J"
           J(k,n-1) = T{k,{'J'}}; 
        end
    end
end
end
