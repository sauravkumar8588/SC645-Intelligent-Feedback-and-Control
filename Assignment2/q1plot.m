s = tf('s');


kp1= 3;
ki1= 0.1;

num = [kp1, ki1];
den = [10,(1+kp1),  ki1];
G1 = tf(num, den);


kp2= 1;
ki2= 0.5;

num = [kp2, ki2];
den = [2,(1+kp2),  ki2];
G2 = tf(num, den);

%rlocus(G2);
%rlocus(G1);
out.yout{1}.Values.plot
hold on 
out.yout{2}.Values.plot

