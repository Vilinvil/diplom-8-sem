function [mergeResult] = clasterization_kmeans_lines(lines, image)
    maxY = size(image, 2);

    [K, B] = convert_lines_to_parameters(lines, maxY);
    
    figure, imshow(image),title('lines'), hold on;
    figure_lines_by_parameters(K, B, maxY, 'green');
    
    numberClasses = 6;
    phi = atan(K);
    normB = B / max(B(:));
    lineParameters = [phi, normB];
    
    for curNumberClasses = 3:numberClasses
        [classIdxes, ~] = kmeans(lineParameters, curNumberClasses);
        figure, imshow(image),title('Classificated by K,B param numberClasses = ' + ...
            string(curNumberClasses)), hold on;
        figure_classificated_lines_by_parametrs(K, B, maxY, classIdxes, curNumberClasses);
    end
    
    mergeResult = [phi, normB, classIdxes];
end
