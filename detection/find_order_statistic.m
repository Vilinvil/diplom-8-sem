function [idxOriginal] = find_order_statistic(array, k)
    if length(array) == 1 && k == 1
        idxOriginal = 1;

        return;
    end

    left = 1; 
    right = length(array);

    idxZero = find_idx_zero(array);
    if idxZero ~= 0
        k = fix((idxZero - left)*k/right) + 1;
        right = idxZero - 1;
    end
    
    idxesOriginal = zeros(right - left + 1, 1);

    % in first time enrichment data with idxes in original array
    [mid, array, idxesOriginal] = partion_with_enrichment(...
        array, idxesOriginal, left, right);
    if mid == k
        idxOriginal = idxesOriginal(mid);

        return;
    elseif (k < mid)
        right = mid;
    else 
        left = mid + 1;
    end

    
    while 1
        [mid, array, idxesOriginal] = partition(...
            array, idxesOriginal, left, right);
        
        if mid == k
            idxOriginal = idxesOriginal(mid);
            
            return;
        elseif (k < mid)
            right = mid;
        else 
            left = mid + 1;
        end
    end
end


function [idx, array, idxesOriginal] = partition(...
    array, idxesOriginal, left, right)
    pivot = array(fix((left + right) / 2));
    i = left;
    j = right;

    while i<=j
        while array(i) < pivot
            i = i + 1;
        end

        while array(j) > pivot
            j = j - 1;
        end

        if i >= j
            break;
        end
        
        [array(j), array(i)] = swap(array(i),array(j));
        [idxesOriginal(j), idxesOriginal(i)] = swap(...
            idxesOriginal(i), idxesOriginal(j));
        i = i + 1;
        j = j - 1;
    end
    

    idx = j;

end

function [idx, array, idxesOriginal] = partion_with_enrichment(...
    array, idxesOriginal, left, right)
    pivot = array(fix((left + right) / 2));
    i = left;
    j = right;

    while i<=j
        while array(i) < pivot
            idxesOriginal(i) = i;
            i = i + 1;
        end

        while array(j) > pivot
            idxesOriginal(j) = j;
            j = j - 1;
        end

        if i >= j
            break;
        end
        
        idxesOriginal(i) = i;
        idxesOriginal(j) = j;
        [array(j), array(i)] = swap(array(i), array(j));
        [idxesOriginal(j), idxesOriginal(i)] = swap(...
            idxesOriginal(i), idxesOriginal(j));
        i = i + 1;
        j = j - 1;
    end
    
    if idxesOriginal(j) == 0
       idxesOriginal(j) = j;
    end

    idx = j;

end

function [b, a] = swap(a, b)
    temp = a;
    a = b;
    b = temp;
end
