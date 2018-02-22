
function main

clc
clear all
clear global
close all
format long
%
% VTR		"Value To Reach" (stop when ofunc < VTR)
% D		number of parameters of the objective function 
% XVmin,XVmax   vector of lower and bounds of initial population
%    		the algorithm seems to work well only if [XVmin,XVmax] 
%    		covers the region where the global minimum is expected
%               *** note: these are no bound constraints!! ***
% y		problem data vector (remains fixed during optimization)
% NP            number of population members
% itermax       maximum number of iterations (generations)
% F             DE-stepsize F ex [0, 2]
% CR            crossover probabililty constant ex [0, 1]
% strategy       1 --> DE/best/1/exp           6 --> DE/best/1/bin
%                2 --> DE/rand/1/exp           7 --> DE/rand/1/bin
%                3 --> DE/rand-to-best/1/exp   8 --> DE/rand-to-best/1/bin
%                4 --> DE/best/2/exp           9 --> DE/best/2/bin
%                5 --> DE/rand/2/exp           else  DE/rand/2/bin
% refresh       intermediate output will be produced after "refresh"
%               iterations. No intermediate output will be produced
%               if refresh is < 1
%
% Parameters
%

initial_time = cputime; 
VTR = 1.e-10; 
D = 3;
%% o Motor oficial está no INDICE 9
XVmin = [1 1 2]; % motor 1->32 helice 1->16 numCelula autom.
XVmax = [32 14 6];

y=[]; 
NP = 10*D; 
itermax = 200; 
F = 0.8; 
CR = 0.5; 
strategy=7;
refresh=5;

[X,FO,NF]=differential_evolution('FuncaoObjetivo_modificada',VTR,D,XVmin,XVmax,y,NP,itermax,F,CR,strategy,refresh)

