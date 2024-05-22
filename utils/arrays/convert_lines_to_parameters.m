function [K, B] = convert_lines_to_parameters(lines)
K = zeros([length(lines) 1]);
B = zeros([length(lines) 1]);
    for i = 1:length(lines)
        [curK, curB] = calc_parameters_of_line(lines(i).point1, lines(i).point2);
        K(i) = curK;
        B(i) = curB;
    end
end