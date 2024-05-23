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


% clasterization_kmeans_points(lines, image);
% clasterization_dbscan_points(lines, image);
[mergeResultKmeansLines] = clasterization_kmeans_lines(lines, image);
[mergeResultDbsacnLines] = clasterization_dbscan_lines(lines, image);

totalMergeResult = [mergeResultKmeansLines, mergeResultDbsacnLines];
