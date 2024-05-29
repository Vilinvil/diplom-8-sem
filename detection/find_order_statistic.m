function [elem] = find_order_statistic(array, k)
    if length(array) == 1 && k == 1
        elem.idxOriginal = 1;

        return;
    end

    left = 1; 
    right = length(array);

    % in first time enrichment data with idxes in original array
    [mid, array] = partion_with_enrichment(array, left, right);
    if mid == k
        elem = array(mid);
    elseif (k < mid)
        right = mid;
    else 
        left = mid + 1;
    end

    
    while 1
        [mid, array] = partition(array, left, right);
        
        if mid == k
            elem = array(mid);
            break;
        elseif (k < mid)
            right = mid;
        else 
            left = mid + 1;
        end
    end
end


function [idx, array] = partition(array, left, right)
    pivot = array(fix((left + right) / 2));
    i = left;
    j = right;

    while i<=j
        while array(i).len < pivot.len
            i = i + 1;
        end

        while array(j).len > pivot.len
            j = j - 1;
        end

        if i >= j
            break;
        end
        
        [array(j), array(i)] = swap(array(i),array(j));
        i = i + 1;
        j = j - 1;
    end
    
    if isempty(array(j).idxOriginal)
        array(j).idxOriginal = j;
    end

    idx = j;

end

function [idx, array] = partion_with_enrichment(array, left, right)
    pivot = array(fix((left + right) / 2));
    i = left;
    j = right;

    while i<=j
        while array(i).len < pivot.len
            array(i).idxOriginal = i;
            i = i + 1;
        end

        while array(j).len > pivot.len
            array(j).idxOriginal = j;
            j = j - 1;
        end

        if i >= j
            break;
        end
        
        array(i).idxOriginal = i;
        array(j).idxOriginal = j;
        [array(j), array(i)] = swap(array(i), array(j));
        i = i + 1;
        j = j - 1;
    end
    
    if isempty(array(j).idxOriginal)
        array(j).idxOriginal = j;
    end

    idx = j;

end

function [b, a] = swap(a, b)
    temp = a;
    a = b;
    b = temp;
end
