clear, close all;
imageFileName = ('./test1_0.jpg');

cannySigma = 3;
cannyThreshold = [];
houghParams = struct('threshold', 0.5, 'peaks', 4, 'FillGap', 3, 'MinLength', 5);
epsDbscan = 0.25;

minAngleRotate = -6;
maxAngleRotate = -1;
stepAngleRotate = 1;

rotatedImages = generate_array_rotated_image(...
    imageFileName, minAngleRotate, maxAngleRotate, stepAngleRotate);

diffsPhi = zeros(size(rotatedImages, 1), 1);

for idxCur = 1:size(rotatedImages, 1)
    curImage = double(squeeze(rotatedImages(idxCur, :, :, :))) / 255;
    difPsi = calc_dif_phi(curImage,  ...
        cannySigma, cannyThreshold, houghParams, epsDbscan);
    diffsPhi(idxCur) = difPsi;
end
