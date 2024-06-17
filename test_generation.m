clear, close all;
addpath('.\utils\arrays', ".\clasterization", '.\figure', ...
    '.\detection', '.\borders', '.\utils');
imageFileName = ('./test_simulink.jpg');

cannySigma = 3;
cannyThreshold = [];
houghParams = struct('threshold', 0.5, 'peaks', 4, 'FillGap', 3, 'MinLength', 5);
epsDbscan = 0.25;

minAngleRotate = -90;
maxAngleRotate = 90;
stepAngleRotate = 0.5;

rotatedImages = generate_array_rotated_image(...
    imageFileName, minAngleRotate, maxAngleRotate, stepAngleRotate);

anglesPsi = zeros(size(rotatedImages, 1), 1);

for idxCur = 1:size(rotatedImages, 1)
    curImage = double(squeeze(rotatedImages(idxCur, :, :, :))) / 255;
    % figure, imshow(curImage), title("Повернуто на " + ...
    %     string(minAngleRotate + (idxCur - 1)*stepAngleRotate) + " градусов");

    psi = calc_dif_psi(0, curImage,  ...
        cannySigma, cannyThreshold, houghParams, epsDbscan);
    anglesPsi(idxCur) = (psi) / pi * 180;
end
