clear, close all;
addpath('.\utils\arrays', ".\clasterization", '.\figure', '.\detection', '.\borders');

imageFileName = ('./test1_0.jpg');

cannySigma = 3;
cannyThreshold = [];
houghParams = struct('threshold', 0.5, 'peaks', 4, 'FillGap', 3, 'MinLength', 5);
epsDbscan = 0.25;

minAngleRotate = -30;
maxAngleRotate = 30;
stepAngleRotate = 15;

rotatedImages = generate_array_rotated_image(...
    imageFileName, minAngleRotate, maxAngleRotate, stepAngleRotate);

diffsPsi = zeros(size(rotatedImages, 1), 1);

for idxCur = 1:size(rotatedImages, 1)
    curImage = double(squeeze(rotatedImages(idxCur, :, :, :))) / 255;
    figure, imshow(curImage), title("Повернуто на " + ...
        string(minAngleRotate + (idxCur - 1)*stepAngleRotate) + " градусов");

    difPsi = calc_dif_phi(curImage,  ...
        cannySigma, cannyThreshold, houghParams, epsDbscan);
    diffsPsi(idxCur) = difPsi;
end
