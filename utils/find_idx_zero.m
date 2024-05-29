function idxZero = find_idx_zero(array)
    for i = 1:length(array)
        if array(i) == 0
            idxZero = i;
            return;
        end
    end

    idxZero = 0;
end