function figure_peaks_hough_space(peaks, theta, rho)
axis on, axis normal, hold on;
plot(theta(peaks(:,2)),rho(peaks(:,1)),'s','color','red');
end
