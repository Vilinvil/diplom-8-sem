function [len] = get_len_line(line)
    len = sqrt((line.point1(1) - line.point2(1))^2 + (line.point1(2) - line.point2(2))^2);
end
