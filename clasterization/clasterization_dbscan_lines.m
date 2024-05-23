function [mergeResult] = clasterization_dbscan_lines(lines, image)
    maxY = size(image, 2);

    [K, B] = convert_lines_to_parameters(lines, maxY);
    
    figure, imshow(image),title('lines'), hold on;
    figure_lines_by_parameters(K, B, maxY, 'green');

    phi = atan(K);
    normB = B / max(B(:));
    lineParameters = [phi, normB];

    maxDiff = 0.1;
    minCountNeighbors = 2;

    classIdxes = dbscan(lineParameters, maxDiff, minCountNeighbors);
    numberClasses = max(classIdxes);
    
    for i = 1:length(classIdxes)
        if classIdxes(i) == -1
            classIdxes(i) = numberClasses + 1;
        end
    end
    
    numberClasses = numberClasses + 1;
    
    figure_classificated_lines_by_parametrs(K, B, maxY, classIdxes, numberClasses);

    mergeResult = [phi, normB, classIdxes];

end