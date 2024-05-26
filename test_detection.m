clear;close all;
addpath('.\utils\arrays', ".\clasterization", '.\figure', '.\detection', '.\borders');

imageFileName = ('./test_image.jpg');
cannySigma = 1.4;
cannyThreshold = [];
houghParams = struct('threshold', 0.5, 'peaks', 4, 'FillGap', 3, 'MinLength', 5);

[lines, blackWhiteImage] = get_borders_lines( ...
    imageFileName,  cannySigma, cannyThreshold, houghParams);

figure, imshow(blackWhiteImage),title('После выделения отрезков'), hold on;
figure_lines_by_two_points(lines);

maxY = size(blackWhiteImage, 2);
[K, B, lines] = convert_lines_to_parameters(lines, maxY);

figure, imshow(blackWhiteImage),title('Прямые'), hold on;
figure_lines_by_parameters(K, B, maxY, 'green');

% clasterization_kmeans_points(lines, blackWhiteImage);
% clasterization_dbscan_points(lines, blackWhiteImage);

phi = atan(K);
normB = B / max(B(:));
lineParameters = [phi, normB];

% minNumberClasses = 2;
% maxNumberClasses = 5; 
% [KmeansLinesMergeResult] = clasterization_kmeans_lines(lineParameters, ...
%     minNumberClasses, maxNumberClasses);
% 
% for curIdxMergeResult = 1:(maxNumberClasses - minNumberClasses + 1)
%         figure, imshow(blackWhiteImage),title('Метод kmeans lines, число классов = ' + ...
%             string(KmeansLinesMergeResult.numberClasses)), hold on;
%         figure_classificated_lines_by_parametrs(K, B, maxY, ...
%             KmeansLinesMergeResult.classIdxes(:, curIdxMergeResult), KmeansLinesMergeResult.numberClasses);
% end

maxDiff = 0.2;
minCountNeighbors = 2;
[DbscanLinesClassIdxess, DbscanLinesNumberClasses, DbscanFlagExistenceMinus] = ... 
    clasterization_dbscan_lines(lineParameters, maxDiff, minCountNeighbors);

    
figure, imshow(blackWhiteImage),title('Метод dbscan lines, число классов=' + ...
    string(DbscanLinesNumberClasses) + ' Eсть ли не классифицированные=' + ...
    string(DbscanFlagExistenceMinus)), hold on;
figure_classificated_lines_by_parametrs(K, B, maxY, ...
    DbscanLinesClassIdxess, DbscanLinesNumberClasses);

lengths = convert_lines_to_lengths(lines);

%  20 degrees
thresholdK = 20 * pi / 180; 

[kAxis, bAxis, k1, b1, k2 , b2] = detect_axis_of_symmetry(lengths, K, B, ... 
    DbscanLinesClassIdxess, DbscanLinesNumberClasses, thresholdK);

figure, imshow(blackWhiteImage),title('Ось трубопровода'), hold on;
figure_lines_by_parameters(kAxis, bAxis, maxY, 'red');
figure_lines_by_parameters(k1, b1, maxY, 'green');
figure_lines_by_parameters(k2, b2, maxY, 'green');

% mergeResult = [DbscanLinesClassIdxess, KmeansLinesMergeResult.classIdxes, lineParameters];