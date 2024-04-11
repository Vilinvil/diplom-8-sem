clear;close all;
addpath('.\figure');
addpath('.\utils_arrays');

image = imread('./test1_.jpg');
figure, imshow(image);title('original');
image = rgb2gray(image);
% figure, imshow(image);title('gray');

%gausImg = imgaussfilt(image,2);
%figure, imshow(gausImg);title('gaus');

cannyImg=edge(image,'canny', [], 3.4); % 3.4 begin
figure,imshow(cannyImg);title('canny');


[H,theta,rho] = hough(cannyImg);

% figure_hough_space(H, theta, rho);

peaks = houghpeaks(H,5,'threshold',ceil(0.7*max(H(:)))); % 0.7 begin

% figure_peaks_hough_space(peaks, theta, rho);

lines = houghlines(cannyImg,theta,rho,peaks,'FillGap',5,'MinLength',7);

figure, imshow(image),title('lines'), hold on;

points = convert_lines_in_points(lines);
plot(points(:,1),points(:,2),'k*','MarkerSize',5);


% maxLen = 0;
% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > maxLen)
%       maxLen = len;
%       xyLong = xy;
%    end
% end
% 
% plot(xyLong(:,1),xyLong(:,2),'LineWidth',2,'Color','red');