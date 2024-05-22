function figure_lines_by_parameters(K, B, maxY, Color)
y = 0:maxY;
    for i = 1:length(K)
        x = (y - B(i)) / K(i);
        plot(x, y,'LineWidth',1,'Color', Color);
    end
end