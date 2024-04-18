clear;close all;
addpath('.\figure');
addpath('.\utils_arrays');

rng(1); % TODO remove because this for repeated results

image = imread('./test1_.jpg');
figure, imshow(image);title('original');
image = rgb2gray(image);
% figure, imshow(image);title('gray');

%gausImg = imgaussfilt(image,2);
%figure, imshow(gausImg);title('gaus');

cannyImg=edge(image,'canny', [], 3.4); % 3.4 begin
figure,imshow(cannyImg);title('canny');

[H,theta,rho] = hough(cannyImg);
peaks = houghpeaks(H,5,'threshold',ceil(0.2*max(H(:)))); % 0.7 begin

% figure_hough_space(H, theta, rho);
% figure_peaks_hough_space(peaks, theta, rho);

lines = houghlines(cannyImg,theta,rho,peaks,'FillGap',5,'MinLength',7);

figure, imshow(image),title('lines'), hold on;

points = convert_lines_in_points(lines, 10);
plot(points(:, 1), points(:, 2), 'k*','MarkerSize',5)

for numberClasses = 1:6
    [classIdxes, centerPoints] = kmeans(points, numberClasses);
    figure, imshow(image),title('linesClassificated numberClasses = ' + string(numberClasses)), hold on;
    figure_classificated_points(points, classIdxes, numberClasses);
end
