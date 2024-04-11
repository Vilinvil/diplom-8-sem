function figure_hough_space(H,theta, rho)
 figure;
 imshow(imadjust(mat2gray(H)),'XData',theta,'YData',rho,'InitialMagnification','fit');
 title('Hough transform');
 xlabel('\theta'), ylabel('\rho');
end
