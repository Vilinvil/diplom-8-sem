function [mergeResult] = clasterization_kmeans_lines(lineParameters, ...
    minNumberClasses, maxNumberClasses)

    curNumberClasses = minNumberClasses;
    sizeMergeResult = (maxNumberClasses - minNumberClasses + 1);

    mergeResult.classIdxes = zeros([size(lineParameters, 1) sizeMergeResult]);
    mergeResult.numberClasses = zeros(sizeMergeResult);
    curIdxMergeResult = 1;
    
    while curNumberClasses <= maxNumberClasses
        [classIdxes, ~] = kmeans(lineParameters, curNumberClasses);
        mergeResult.classIdxes(:, curIdxMergeResult) = classIdxes;
        mergeResult.numberClasses(curNumberClasses - minNumberClasses + 1) = ...
            curNumberClasses;

        curNumberClasses = curNumberClasses + 1;
        curIdxMergeResult = curIdxMergeResult + 1;
    end
end
