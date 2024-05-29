function [lengths] = set_zero_length_to_not_classificated(... 
    classIdxes, numberClassMinus, lengths)

    for curIdx = 1:length(classIdxes)
        if classIdxes(curIdx) == numberClassMinus
            lengths(curIdx) = 0;
        end
    end
end

