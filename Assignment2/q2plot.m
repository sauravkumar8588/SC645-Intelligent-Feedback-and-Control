

s = tf('s');
num = 1;
den = [1, 0, 2];
G1 = tf(num, den);
G2 = tf(exp(-1.2 * s));

G3 = G1 * G2;






%bode(G3); grid on ;
%[gm] = margin(G3);


nyquist(G3)
