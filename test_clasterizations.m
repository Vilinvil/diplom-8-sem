clear;close all;
addpath('.\utils\arrays', ".\clasterization", '.\figure', '.\detection');

rng(1); % TODO remove because this for repeated results

image = imread('./test1_2_degree.jpg');

figure, imshow(image);title('original');
image = rgb2gray(image);
% figure, imshow(image);title('gray');

gausImg = imgaussfilt(image,2);
%figure, imshow(gausImg);title('gaus');

cannyImg=edge(image,'canny', [], 1.47); 
figure,imshow(cannyImg);title('canny');

[H,theta,rho] = hough(cannyImg);

maxH = max(H(:));
thresholdHoug = ceil(0.5*maxH);
peaks = houghpeaks(H,4,'threshold',thresholdHoug);

 % figure_hough_space(H, theta, rho);
 % figure_peaks_hough_space(peaks, theta, rho);

lines = houghlines(cannyImg,theta,rho,peaks,'FillGap',3,'MinLength',5);
figure, imshow(image),title('points'), hold on;
figure_lines_by_two_points(lines);

maxY = size(image, 2);
[K, B, lines] = convert_lines_to_parameters(lines, maxY);

figure, imshow(image),title('lines'), hold on;
figure_lines_by_parameters(K, B, maxY, 'green');

% clasterization_kmeans_points(lines, image);
% clasterization_dbscan_points(lines, image);

phi = atan(K);
normB = B / max(B(:));
lineParameters = [phi, normB];

% minNumberClasses = 2;
% maxNumberClasses = 5; 
% [KmeansLinesMergeResult] = clasterization_kmeans_lines(lineParameters, ...
%     minNumberClasses, maxNumberClasses);
% 
% for curIdxMergeResult = 1:(maxNumberClasses - minNumberClasses + 1)
%         figure, imshow(image),title('Метод kmeans lines, число классов = ' + ...
%             string(KmeansLinesMergeResult.numberClasses)), hold on;
%         figure_classificated_lines_by_parametrs(K, B, maxY, ...
%             KmeansLinesMergeResult.classIdxes(:, curIdxMergeResult), KmeansLinesMergeResult.numberClasses);
% end

maxDiff = 0.2;
minCountNeighbors = 2;
[DbscanLinesClassIdxess, DbscanLinesNumberClasses, DbscanFlagExistenceMinus] = ... 
    clasterization_dbscan_lines(lineParameters, maxDiff, minCountNeighbors);

    
figure, imshow(image),title('Метод dbscan lines, число классов=' + ...
    string(DbscanLinesNumberClasses) + ' Eсть ли не классифицированные=' + ...
    string(DbscanFlagExistenceMinus)), hold on;
figure_classificated_lines_by_parametrs(K, B, maxY, ...
    DbscanLinesClassIdxess, DbscanLinesNumberClasses);

lengths = convert_lines_to_lengths(lines);

%  15 degrees
thresholdK = 15 * pi / 180; 

[kAxis, bAxis, k1, b1, k2 , b2] = detect_axis_of_symmetry(lengths, K, B, ... 
    DbscanLinesClassIdxess, DbscanLinesNumberClasses, thresholdK);

figure, imshow(image),title('Ось трубопровода'), hold on;
figure_lines_by_parameters(kAxis, bAxis, maxY, 'red');
figure_lines_by_parameters(k1, b1, maxY, 'green');
figure_lines_by_parameters(k2, b2, maxY, 'green');

% mergeResult = [DbscanLinesClassIdxess, KmeansLinesMergeResult.classIdxes, lineParameters];