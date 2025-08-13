
clc
clear all

s = tf('s');

%defining the given values
R=1;
L=12.25;
C= 0.075;
td = 0.05 ;
T0 = 5;
T=0;
%T=0.5;
%T=1;
%T=1.25;

% trasnsfer function of plant
NUM1 = [1];
DEN1 = [L*C, R*C, 1];
G1= tf(NUM1, DEN1);

% trasnsfer function of sensor
G2 = (1+T/T0)*exp(-s*td);

%combined trasfer function
G3 = G1*G2;


%plotting the nyquist plot
nyquist(G3)


