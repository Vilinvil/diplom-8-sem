function [mergeResult] = clasterization_kmeans_lines(lineParameters, ...
    minNumberClasses, maxNumberClasses)

    curNumberClasses = minNumberClasses;

    mergeResult.classIdxes = zeros([size(lineParameters, 1)  ...
         (maxNumberClasses - minNumberClasses + 1)]);
    curIdxMergeResult = 1;
    
    while curNumberClasses <= maxNumberClasses
        [classIdxes, ~] = kmeans(lineParameters, curNumberClasses);
        mergeResult.classIdxes(:, curIdxMergeResult) = classIdxes;
        mergeResult.numberClasses = curNumberClasses;

        curNumberClasses = curNumberClasses + 1;
        curIdxMergeResult = curIdxMergeResult + 1;
    end

end
