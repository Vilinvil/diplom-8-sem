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


K2Analytically = round((((Tuv + Tdv)/(2*epsw*sqrt(Tdv*Tuv)))^2 - 1) / ...
    (KdvTotal * Kuv), 2);

Tw = sqrt(Tdv * Tuv /(1 + KdvTotal * Kuv * K2Analytically));
Kw = 1 * KdvTotal * Kuv / (1 + KdvTotal * Kuv * K2Analytically);

M = 1.05;

KpsiLessThan = M*M + M*sqrt(M*M - 1) / 4 / Tw;

% let Kpsi = 0.9 without 
Kpsi = 1.5;

K1Analytically = round(Kpsi / Kw, 2);

Eust = Mout / (KdvTotal * K1Analytically) * 180 / pi;
Tcor = 1;
