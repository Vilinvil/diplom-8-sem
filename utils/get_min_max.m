function [min,max] = get_min_max(a,b)
    if a < b 
        min = a;
        max = b;
    else
        min = b;
        max = a;
    end
end

