function [classIdxes, numberClasses] = clasterization_dbscan_lines(lineParameters, ...
    maxDiff, minCountNeighbors)

    classIdxes = dbscan(lineParameters, maxDiff, minCountNeighbors);
    numberClasses = max(classIdxes);
    
    for i = 1:length(classIdxes)
        if classIdxes(i) == -1
            classIdxes(i) = numberClasses + 1;
        end
    end
    
    numberClasses = numberClasses + 1;

end