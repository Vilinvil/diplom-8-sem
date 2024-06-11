clear, close all;
m = 340;
lambda55 = 344;
Jy = 351;
Cwy1  = 259;
Cwy2 = 26;
Kdv = 100;
Tdv = 0.15;
Umax = 10;
a = 0.4;
alpha = pi /4;

Mout = 0;
K1 = 44.8;
K2 = 27.6;

firstPsi = 0 * pi / 180;

Tuv = (lambda55 + Jy) / Cwy2;
epsw = 0.707;
KdvTotal = 4 * 0.4 * cos(alpha) * Kdv;
Kuv = 1 / Cwy2;


K2Analytically = (((Tuv + Tdv)/(2*epsw*sqrt(Tdv*Tuv)))^2 - 1) / ...
    (KdvTotal * Kuv);

Tw = sqrt(Tdv * Tuv /(1 + KdvTotal * Kuv * K2Analytically));
Kw = 1 * KdvTotal * Kuv / (1 + KdvTotal * Kuv * K2Analytically);

M = 1;

KpsiLessThan = M*M + M*sqrt(M*M - 1) / 4 / Tw;

% let Kpsi = 1.3
Kpsi = 0.9;

K1Analytically = Kpsi / Kw;
