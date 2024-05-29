clear, close all;
imageFileName = ('./test1_0.jpg');

cannySigma = 3;
cannyThreshold = [];
houghParams = struct('threshold', 0.5, 'peaks', 4, 'FillGap', 3, 'MinLength', 5);
epsDbscan = 0.25;

minAngleRotate = -19;
maxAngleRotate = -19;
stepAngleRotate = 1;

rotatedImages = generate_array_rotated_image(...
    imageFileName, minAngleRotate, maxAngleRotate, stepAngleRotate);

diffsPhi = zeros(length(rotatedImages));

for idxCur = 1:length(rotatedImages)
    difPhi = calc_dif_phi(rotatedImages{idxCur},  ...
        cannySigma, cannyThreshold, houghParams, epsDbscan);
    diffsPhi(idxCur) = difPhi;
end
