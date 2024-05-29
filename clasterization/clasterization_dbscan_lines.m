function [classIdxes, numberClasses, flagExistenseMinus] = ...
clasterization_dbscan_lines(lineParameters, eps, minCountNeighbors)
    % need for work MATLAB func in simulink     
    coder.extrinsic('dbscan');
    classIdxes = [0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0]; 
    coder.varsize('classIdxes'); 


    [classIdxes, ~] = dbscan(lineParameters, eps, minCountNeighbors);
    
    numberClasses = max(classIdxes(:, 1));
    
    flagExistenseMinus = 0;

    for i = 1:size(classIdxes, 1)
        if classIdxes(i) == -1
            classIdxes(i) = numberClasses + 1;
            flagExistenseMinus = 1;
        end
    end
    
    numberClasses = numberClasses + flagExistenseMinus;

end
