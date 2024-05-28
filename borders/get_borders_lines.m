function [lines, blackWhiteImage] = get_borders_lines( ... 
    image, cannySigma, cannyTreshold, houghParams)

    blackWhiteImage = rgb2gray(image);
    % figure, imshow(blackWhiteImage);title('gray');

    gausImg = imgaussfilt(blackWhiteImage, 1);
    %figure, imshow(gausImg);title('gaus');
    
    cannyImg=edge(gausImg,'canny', cannyTreshold, cannySigma); 
    figure,imshow((cannyImg - 1) * -1);title('canny');
    
    [H,theta,rho] = hough(cannyImg);
    
    maxH = max(H(:));
    thresholdHoug = ceil(houghParams.threshold*maxH);
    peaks = houghpeaks(H,houghParams.peaks,'threshold',thresholdHoug);
    
     % figure_hough_space(H, theta, rho);
     % figure_peaks_hough_space(peaks, theta, rho);

    lines = houghlines(cannyImg,theta,rho,peaks,'FillGap',houghParams.FillGap, ...
        'MinLength',houghParams.MinLength);
     
end