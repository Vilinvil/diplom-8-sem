function clasterization_kmeans_points(lines, image)
    figure, imshow(image),title('points'), hold on;
    points = convert_lines_in_points(lines, 10);
    plot(points(:, 1), points(:, 2), 'k*','MarkerSize',5)

    numberClasses = 6;
    
    for curNumberClasses = 1:numberClasses
        [classIdxes, ~] = kmeans(points, curNumberClasses);
        figure, imshow(image),title('Classificated by points numberClasses = ' + ...
            string(curNumberClasses)), hold on;
        figure_classificated_points(points, classIdxes, curNumberClasses);
    end
end