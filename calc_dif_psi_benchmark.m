addpath('.\utils\arrays', ".\utils", ".\clasterization", ... 
    '.\figure', '.\detection', '.\borders');

image = imread('./test1_0.jpg');

cannySigma = 56;
cannyThreshold = [];
houghParams = struct('threshold', 0.5, 'peaks', 4, 'FillGap', 3, 'MinLength', 5);
epsDbscan = 0.25;


funcBench = @() calc_dif_psi(...
    0, image, cannySigma, cannyThreshold, houghParams, epsDbscan);

timeBench = timeit(funcBench);

timeBenchWithReturn = timeit(funcBench, 1);
