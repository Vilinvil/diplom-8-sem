function [kAxis, bAxis, k1, b1, k2, b2] = detect_axis_of_symmetry(lengths, K, B, ...
    classIdxes, numberClasses, thresholdHighPhi)

    lengthsByClass = zeros([length(classIdxes) numberClasses]);
    idxLineByClass = zeros([length(classIdxes) numberClasses]);
    idxesInsert = ones([numberClasses 1]);
    
    for idxCurLine = 1:length(classIdxes)
        curClass = classIdxes(idxCurLine);
        idxInsert = idxesInsert(curClass);
        idxesInsert(curClass) = idxesInsert(curClass) + 1;
        
        lengthsByClass(idxInsert, curClass) = lengths(idxCurLine);
        idxLineByClass(idxInsert, curClass) = idxCurLine;
    end
    
    
    % medianIdxes = zeros([numberClasses 1]);
    % medianLenghts = zeros([numberClasses 1]);
    medianLengthClassIdxes = zeros(numberClasses, 2);

    for idxClass = 1:numberClasses
       curArrayLength = lengthsByClass(:, idxClass);
       medianIdx = fix(length(curArrayLength) / 2) + 1;

       [medianIdxOriginal] = find_order_statistic(curArrayLength, medianIdx);

       medianIdx = idxLineByClass(medianIdxOriginal, idxClass);
       medianLengthClassIdxes(idxClass, 1) = medianIdx;
       medianLengthClassIdxes(idxClass, 2) = lengths(medianIdx);
    end
    
    sortedIdxesMedianLenght = sortrows(medianLengthClassIdxes, 2, 'descend');
    
    maxLengthLineIdx = sortedIdxesMedianLenght(1, 1);
    k1 = K(maxLengthLineIdx);
    b1 = B(maxLengthLineIdx);

    k2 = 0;
    b2 = 0;
    
    for idxCurLine = 2:numberClasses
        curMaxLenghtLineIdx = sortedIdxesMedianLenght(idxCurLine, 1);
        k2 = K(curMaxLenghtLineIdx);
        
        difPhi = abs(abs(atan(k1)) - abs(atan(k2)));
        if difPhi < thresholdHighPhi % && (atan(k1) * atan(k2) < 0)
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
