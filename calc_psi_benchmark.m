clear, close all;
addpath('.\utils\arrays', ".\utils", ".\clasterization", ... 
    '.\figure', '.\detection', '.\borders');

cannySigma = 17;
cannyThreshold = [];
houghParams = struct('threshold', 0.5, 'peaks', 4, 'FillGap',3, 'MinLength', 5);
epsDbscan = 0.25;

countImages = 19;
numberOfTimes = 1000;
timesCall = zeros(1, numberOfTimes * countImages);

for idxCurImage = 1:countImages
    image = imread('./test1_benchmark_rotate_' + string(idxCurImage)...
    + '.jpg');
    maxNumCompThreads(1);

    for idxCurTimes = 1:numberOfTimes     
        tic; toc;
        tStart = tic;         
    
        psi = calc_psi(...
            0, image, cannySigma, cannyThreshold, houghParams, epsDbscan);
        
        tEnd = toc;
        timesCall((idxCurImage - 1)*numberOfTimes + idxCurTimes) = tEnd;
    end

    maxNumCompThreads('automatic');
end

medianTime = median(timesCall);
