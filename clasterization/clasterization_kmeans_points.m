function clasterization_kmeans_points(lines, image)
    figure, imshow(image),title('точки на отрезках'), hold on;
    points = convert_lines_in_points(lines, 10);
    plot(points(:, 1), points(:, 2), 'k*','MarkerSize',5, 'Color', 'green');

    numberClasses = 5;
    
    for curNumberClasses = 2:numberClasses
        [classIdxes, ~] = kmeans(points, curNumberClasses);
        figure, imshow(image),title('KMeans++ на отрезках; число кластеров = ' + ...
            string(curNumberClasses)), hold on;
        figure_classificated_points(points, classIdxes, curNumberClasses);
    end
end
