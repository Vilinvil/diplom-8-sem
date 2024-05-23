clear;close all;
addpath('.\utils\arrays', ".\clasterization", '.\figure');

rng(1); % TODO remove because this for repeated results

image = imread('./test1_2_degree.jpg');

figure, imshow(image);title('original');
image = rgb2gray(image);
% figure, imshow(image);title('gray');

gausImg = imgaussfilt(image,2);
%figure, imshow(gausImg);title('gaus');

cannyImg=edge(image,'canny', [], 1.47); % 3.4 begin
figure,imshow(cannyImg);title('canny');

[H,theta,rho] = hough(cannyImg);

maxH = max(H(:));
thresholdHoug = ceil(0.5*maxH);
peaks = houghpeaks(H,4,'threshold',thresholdHoug); % 0.7 begin

 % figure_hough_space(H, theta, rho);
 % figure_peaks_hough_space(peaks, theta, rho);

lines = houghlines(cannyImg,theta,rho,peaks,'FillGap',3,'MinLength',5);
figure, imshow(image),title('points'), hold on;
figure_lines_by_two_points(lines);

maxY = size(image, 2);
[K, B] = convert_lines_to_parameters(lines, maxY);

figure, imshow(image),title('lines'), hold on;
figure_lines_by_parameters(K, B, maxY, 'green');

% clasterization_kmeans_points(lines, image);
% clasterization_dbscan_points(lines, image);

phi = atan(K);
normB = B / max(B(:));
lineParameters = [phi, normB];

minNumberClasses = 2;
maxNumberClasses = 5; 
[KmeansLinesMergeResult] = clasterization_kmeans_lines(lineParameters, ...
    minNumberClasses, maxNumberClasses);

for curIdxMergeResult = 1:(maxNumberClasses - minNumberClasses + 1)
        figure, imshow(image),title('Метод kmeans_lines, число классов = ' + ...
            string(KmeansLinesMergeResult.numberClasses)), hold on;
        figure_classificated_lines_by_parametrs(K, B, maxY, ...
            KmeansLinesMergeResult.classIdxes(:, curIdxMergeResult), KmeansLinesMergeResult.numberClasses);
end

maxDiff = 0.1;
minCountNeighbors = 2;
[DbscanLinesClassIdxess, DbscanLinesNumberClasses] = ... 
    clasterization_dbscan_lines(lineParameters, maxDiff, minCountNeighbors);

    
figure, imshow(image),title('Метод dbscan_lines, число классов=' + ...
    string(DbscanLinesNumberClasses)), hold on;
figure_classificated_lines_by_parametrs(K, B, maxY, ...
    DbscanLinesClassIdxess, DbscanLinesNumberClasses);
