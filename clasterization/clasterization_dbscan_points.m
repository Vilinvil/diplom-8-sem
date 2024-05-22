function clasterization_dbscan_points(lines, image)
    figure, imshow(image),title('lines'), hold on;
       
    maxDiff = 5;
    minCountNeighbors = 3;
    points = convert_lines_in_points_evenly(lines, maxDiff);
    
    classIdxes = dbscan(points, maxDiff, minCountNeighbors);
    numberClasses = max(classIdxes);
    
    for i = 1:length(classIdxes)
        if classIdxes(i) == -1
            classIdxes(i) = numberClasses + 1;
        end
    end
    
    numberClasses = numberClasses + 1;
    
    figure_classificated_points(points, classIdxes, numberClasses);

end