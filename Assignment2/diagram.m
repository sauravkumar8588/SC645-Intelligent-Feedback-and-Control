s = tf('s');


G1 = 1 / (10*s + 1);
kp1 = 3;
ki1 = 0.1;
C1 = (kp1) + (ki1 / s);


G2 = 1 / (2*s + 1);
kp2 = 1;
ki2 = 0.5;
C2 = (kp2) + (ki2/s);

out.yout{1}.Values.plot
hold on 
out.yout{2}.Values.plot