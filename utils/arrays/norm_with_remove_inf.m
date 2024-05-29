function [array] = norm_with_remove_inf(array)
    max = 0;
    idxesInf = [];
    for idxCur = 1:length(array)
        curElem = abs(array(idxCur));
        if isinf(curElem)
            idxesInf = [idxesInf, idxCur];
            continue;
        end
        
        if curElem > max
            max = curElem;
        end
    end

    for idxCur = 1:length(idxesInf)
        array(idxesInf(idxCur)) = max;
    end

    array = array / max;
end

