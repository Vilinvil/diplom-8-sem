function [points, classIdxes, numberClasses, flagExistenseMinus] = ... 
    clasterization_dbscan_points(lines)

    eps = 15;
    minCountNeighbors = 3;
    points = convert_lines_in_points_evenly(lines, eps);
    
    classIdxes = dbscan(points, eps, minCountNeighbors);

    numberClasses = max(classIdxes);
    flagExistenseMinus = 0;

    for i = 1:length(classIdxes)
        if classIdxes(i) == -1
            classIdxes(i) = numberClasses + 1;
            flagExistenseMinus = 1;
        end
    end
    
    numberClasses = numberClasses + flagExistenseMinus;
end
