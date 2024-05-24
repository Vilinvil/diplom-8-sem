function [classIdxes, numberClasses, flagExistenseMinus] = ...
clasterization_dbscan_lines(lineParameters,maxDiff, minCountNeighbors)

    classIdxes = dbscan(lineParameters, maxDiff, minCountNeighbors);

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