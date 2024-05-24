function [lengths] = convert_lines_to_lengths(lines)
    lengths = zeros([length(lines) 1]);

    for idx = 1:length(lines)
        lengths(idx) = get_len_line(lines(idx));
    end

end