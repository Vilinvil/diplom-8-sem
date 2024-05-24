function [kAxis, bAxis, k1, b1, k2, b2] = detect_axis_of_symmetry(lengths, K, B, ...
    classIdxes, numberClasses, threshholdPhi)
    lengthsByClass = cell(1, numberClasses);
    
    for idxCurLine = 1:length(classIdxes)
        curClass = classIdxes(idxCurLine);
        lengthsByClass{curClass} = [lengthsByClass{curClass}, ...
            struct('len', lengths(idxCurLine), 'idxLine', idxCurLine)];
    end
    
    
    medianLengthClassIdxes = cell([numberClasses 1]);

    for idxClass = 1:numberClasses
       curArrayLength = lengthsByClass{idxClass};
       medianIdx = ceil(length(curArrayLength) / 2) + 1;

       [medianElem] = find_order_statistic(curArrayLength, medianIdx);

       medianIdx = curArrayLength(medianElem.idxOriginal).idxLine;
       medianLengthClassIdxes{idxClass} = struct('medianIdx', medianIdx, ...
           'len', lengths(medianIdx));
    end
    
    [~, sortedIdxesMedianLenght] = sort(cellfun(@(x) x.len, ... 
        medianLengthClassIdxes), 'descend');
    
    maxLengthLineIdx = medianLengthClassIdxes{sortedIdxesMedianLenght(1)}.medianIdx;
    k1 = K(maxLengthLineIdx);
    b1 = B(maxLengthLineIdx);

    k2 = 0;
    b2 = 0;
    
    for idxCurLine = 2:numberClasses
        curMaxLenghtLineIdx = medianLengthClassIdxes{sortedIdxesMedianLenght(idxCurLine)}.medianIdx;
        
        k2 = K(curMaxLenghtLineIdx);
        if abs(atan(k1) - atan(k2)) < threshholdPhi
            b2 = B(curMaxLenghtLineIdx);
            break;
        end

        k2 = 0;
    end

    if k2 == 0 && b2 == 0
        kAxis = 0;
        bAxis = 0;

        return;
    end

    [kAxis, bAxis] = calc_parameters_axis_of_symmetry(k1, k2, b1, b2);

end
