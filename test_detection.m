clear, close all;
addpath('.\utils\arrays', ".\clasterization", '.\figure', '.\detection', '.\borders');

image = imread('./test1_5.jpg');
figure, imshow(image);title('Изначально');

cannySigma = 40;
cannyThreshold = [0.01 0.5];
houghParams = struct('threshold', 0.2, 'peaks', 2, 'FillGap', 3, 'MinLength', 1);

[lines, blackWhiteImage] = get_borders_lines( ...
    image,  cannySigma, cannyThreshold, houghParams);

figure, imshow(blackWhiteImage),title('После выделения отрезков'), hold on;
figure_lines_by_two_points(lines);

maxY = size(blackWhiteImage, 2);
[K, B, lines] = convert_lines_to_parameters(lines, maxY);

figure, imshow(blackWhiteImage),title('Прямые'), hold on;
figure_lines_by_parameters(K, B, maxY, 'green');

% clasterization_kmeans_points(lines, blackWhiteImage);

phi = atan(K);
normB = norm_with_remove_inf(B);
lineParameters = [phi, normB];

% minNumberClasses = 2;
% maxNumberClasses = 5; 
% [KmeansLinesMergeResult] = clasterization_kmeans_lines(lineParameters, ...
%     minNumberClasses, maxNumberClasses);
% 
% for curIdxMergeResult = 1:(maxNumberClasses - minNumberClasses + 1)
%         curNumberClasses = KmeansLinesMergeResult.numberClasses(curIdxMergeResult);
%         figure, imshow(blackWhiteImage),title('KMeans++ на параметрах прямых k, b; число кластеров = ' + ...
%             string(curNumberClasses)), hold on;
%         figure_classificated_lines_by_parametrs(K, B, maxY, ...
%             KmeansLinesMergeResult.classIdxes(:, curIdxMergeResult), curNumberClasses);
% end

% [dbscanPoints, dbscanPointsClassIdxes, dbscanPointsNumberClasses, ...
%     dbscanPointsFlagExistanseMinus] = clasterization_dbscan_points(lines);
% 
% figure, imshow(blackWhiteImage),title('DBSCAN по точкам; число кластеров = ' + ...
%     string(dbscanPointsNumberClasses) + '; есть ли не классифицированные = ' ...
%     + string(dbscanPointsFlagExistanseMinus)), hold on;
% figure_classificated_points(dbscanPoints, dbscanPointsClassIdxes, dbscanPointsNumberClasses);

eps = 0.25;
minCountNeighbors = 2;
[DbscanLinesClassIdxess, DbscanLinesNumberClasses, DbscanFlagExistenceMinus] = ... 
    clasterization_dbscan_lines(lineParameters, eps, minCountNeighbors);


figure, imshow(blackWhiteImage),title('Метод dbscan lines, число классов=' + ...
    string(DbscanLinesNumberClasses) + ' Eсть ли не классифицированные=' + ...
    string(DbscanFlagExistenceMinus)), hold on;
figure_classificated_lines_by_parametrs(K, B, maxY, ...
    DbscanLinesClassIdxess, DbscanLinesNumberClasses);

lengths = convert_lines_to_lengths(lines);
% if DbscanFlagExistenceMinus
%     lengths = set_zero_length_to_not_classificated(... 
%         DbscanLinesClassIdxess, DbscanLinesNumberClasses, lengths);
% end

thresholdHighPhi = 30 * pi / 180; 

[kAxis, bAxis, k1, b1, k2 , b2] = detect_axis_of_symmetry(lengths, K, B, ... 
    DbscanLinesClassIdxess, DbscanLinesNumberClasses, thresholdHighPhi);

figure, imshow(blackWhiteImage),title('Ось трубопровода'), hold on;
figure_lines_by_parameters(kAxis, bAxis, maxY, 'red');
figure_lines_by_parameters(k1, b1, maxY, 'green');
    figure_lines_by_parameters(k2, b2, maxY, 'green');
