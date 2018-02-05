
%%BASE DE DADOS REFERENTE A MOTORES ELÉTRICOS
clear all;
clc;

%% Parametros dos motores AXI
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Parâmetros para motores da Marca Scorpions

kv(33) = 690; %%Scorpion SII-3032-690KV -- Novo (encontrado no site do fabricante)
i0(33) = 2.71;
r(33) = 0.022;
imax(33) = 60;
massa(33) = 275;% gramas
sm{33} = 'Scorpion SII-3032-690KV';

kv(34) = 1070; %%Scorpion SII-2212-1070KV
i0(34) = 0.59;
r(34) = 0.091;
imax(34) = 15;
massa(34) = 58;% gramas
sm{34} = 'Scorpion SII-2212-1070KV';

kv(35) = 1850; %%Scorpion SII-2212-1850KV
i0(35) = 1.31;
r(35) = 0.032;
imax(35) = 22;
massa(35) = 58;% gramas
sm{35} = 'Scorpion SII-2212-1850KV';

kv(36) = 1400; %%Scorpion SII-2212-1400KV
i0(36) = 0.73;
r(36) = 0.091;
imax(36) = 25;
massa(36) = 58;% gramas
sm{36} = 'Scorpion SII-2212-1400KV';

kv(37) = 900; %%Scorpion SII-2215-900KV
i0(37) = 0.52;
r(37) = 0.142;
imax(37) = 16;
massa(37) = 68.6;% gramas
sm{37} = 'Scorpion SII-2215-900KV';

kv(38) = 1127; %%Scorpion SII-2215-1127KV
i0(38) = 0.73;
r(38) = 0.078;
imax(38) = 20;
massa(38) = 68.6;% gramas
sm{38} = 'Scorpion SII-2215-1127KV';

kv(39) = 1810; %%Scorpion SII-2215-1810KV
i0(39) = 1.35;
r(39) = 0.031;
imax(39) = 25;
massa(39) = 68.6;% gramas
sm{39} = 'Scorpion SII-2215-1810KV';

kv(40) = 1400; %%Scorpion SII-2215-1400KV
i0(40) = 0.595;
r(40) = 0.095;
imax(40) = 35;
massa(40) = 68.6;% gramas
sm{40} = 'Scorpion SII-2215-1400KV';

kv(41) = 1090; %%Scorpion SII-3008-1090KV
i0(41) = 0.79;
r(41) = 0.058;
imax(41) = 26;
massa(41) = 95;% gramas
sm{41} = 'Scorpion SII-3008-1090KV';

kv(42) = 1220; %%Scorpion SII-3008-1220KV
i0(42) = 0.97;
r(42) = 0.042;
imax(42) = 32;
massa(42) = 95;% gramas
sm{42} = 'Scorpion SII-3008-1220KV';

kv(43) = 830; %%Scorpion SII-3014-830KV
i0(43) = 1.06;
r(43) = 0.042;
imax(43) = 30;
massa(43) = 129;% gramas
sm{43} = 'Scorpion SII-3014-830KV';

kv(44) = 1040; %%Scorpion SII-3014-1040KV
i0(44) = 1.35;
r(44) = 0.026;
imax(44) = 40;
massa(44) = 129;% gramas
sm{44} = 'Scorpion SII-3014-1040KV';

kv(45) = 1220; %%Scorpion SII-3014-1220KV
i0(45) = 1.64;
r(45) = 0.018;
imax(45) = 46;
massa(45) = 129;% gramas
sm{45} = 'Scorpion SII-3014-1220KV';

kv(46) = 780; %%Scorpion SII-3020-780KV
i0(46) = 1.21;
r(46) = 0.03;
imax(46) = 40;
massa(46) = 166;% gramas
sm{46} = 'Scorpion SII-3020-780KV';

kv(47) = 890; %%Scorpion SII-3020-890KV
i0(47) = 1.42;
r(47) = 0.02;
imax(47) = 45;
massa(47) = 166;% gramas
sm{47} = 'Scorpion SII-3020-890KV';

kv(48) = 1110; %%Scorpion SII-3020-1110KV
i0(48) = 2.08;
r(48) = 0.016;
imax(48) = 60;
massa(48) = 166;% gramas
sm{48} = 'Scorpion SII-3020-1110KV';

kv(49) = 710; %%Scorpion SII-3026-710KV
i0(49) = 1.56;
r(49) = 0.022;
imax(49) = 60;
massa(49) = 205;% gramas
sm{49} = 'Scorpion SII-3026-710KV';
% 
kv(50) = 890; %%Scorpion SII-3026-890KV
i0(50) = 1.9;
r(50) = 0.014;
imax(50) = 70;
massa(50) = 205;% gramas
sm{50} = 'Scorpion SII-3026-890KV';

kv(51) = 1190; %%Scorpion SII-3026-1190KV
i0(51) = 3.26;
r(51) = 0.008;
imax(51) = 80;
massa(51) = 205;% gramas
sm{51} = 'Scorpion SII-3026-1190KV';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Parâmetros para motores da Marca Emax

kv(52) = 1200; %%Emax CF-2822-1200KV
i0(52) = 0.9;
r(52) = 0.15;
imax(52) = 16;
massa(52) = 39;% gramas
sm{52} = 'Emax CF-2822-1200KV';

kv(53) = 920; %%EMAX BL2815 920KV
i0(53) = 2.7;
r(53) = 0.035;
imax(53) = 31;
massa(53) = 112;% gramas
sm{53} = 'EMAX BL2815 920KV';

kv(54) = 919; %%EMAX BL2820 919KV
i0(54) = 2.5;
r(54) = 0.031;
imax(54) = 59;
massa(54) = 144;% gramas
sm{54} = 'EMAX BL2820 919KV';


kv(55) = 850; %%EMAX BL2826 850KV
i0(55) = 2.7;
r(55) = 0.026;
imax(55) = 61;
massa(55) = 182;% gramas
sm{55} = 'EMAX BL2826 850KV';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%para a apresentação
kv(56) = 710; %%Scorpion SII-3026-710KV
i0(56) = 1.56;
r(56) = 0.022;
imax(56) = 60;
massa(56) = 205;% gramas
sm{56} = 'Scorpion SII-3026-710KV';
% 
kv(57) = 890; %%Scorpion SII-3026-890KV
i0(57) = 1.9;
r(57) = 0.014;
imax(57) = 70;
massa(57) = 205;% gramas
sm{57} = 'Scorpion SII-3026-890KV';

kv(58) = 1190; %%Scorpion SII-3026-1190KV
i0(58) = 3.26;
r(58) = 0.008;
imax(58) = 80;
massa(58) = 205;% gramas
sm{58} = 'Scorpion SII-3026-1190KV';


kv(59) = 1200; %%Emax CF-2822-1200KV
i0(59) = 0.9;
r(59) = 0.15;
imax(59) = 16;
massa(59) = 39;% gramas
sm{59} = 'Emax CF-2822-1200KV';

kv(60) = 920; %%EMAX BL2815 920KV
i0(60) = 2.7;
r(60) = 0.035;
imax(60) = 31;
massa(60) = 112;% gramas
sm{60} = 'EMAX BL2815 920KV';


kv(61) = 1380;%% 2217-12
i0(61) = .4;
r(61) = .061;
imax(61) = 30;
massa(61) = 69.5;
sm{61} = 'AXI 2217/12';

kv(62) = 1050;%% 2217-16
i0(62) = 0.4;
r(62) = .120;
imax(62) = 22;
massa(62) = 69.5;
sm{62} = 'AXI 2217/16';


%%SALVANDO EM ARQUIVO .MAT
save('engine_data.mat')
