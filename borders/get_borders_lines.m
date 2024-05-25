function [lines, blackWhiteImage] = get_borders_lines( ... 
    imageFileName, gausSigma, cannyTreshold, houghParams)

    image = imread(imageFileName);
    figure, imshow(image);title('Изначально');

    blackWhiteImage = rgb2gray(image);
    % figure, imshow(blackWhiteImage);title('gray');
    
    cannyImg=edge(blackWhiteImage,'canny', cannyTreshold, gausSigma); 
    figure,imshow(cannyImg);title('canny');
    
    [H,theta,rho] = hough(cannyImg);
    
    maxH = max(H(:));
    thresholdHoug = ceil(houghParams.threshold*maxH);
    peaks = houghpeaks(H,houghParams.peaks,'threshold',thresholdHoug);
    
     % figure_hough_space(H, theta, rho);
     % figure_peaks_hough_space(peaks, theta, rho);

    lines = houghlines(cannyImg,theta,rho,peaks,'FillGap',houghParams.FillGap, ...
        'MinLength',houghParams.MinLength);
     
end