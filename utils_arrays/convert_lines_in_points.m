function [points] = convert_lines_in_points(lines)
    for i = 0:length(lines)
        points = [points; lines(i).point1[0], lines(i).point1[1]];
        points = [points; lines(i).point2[0], lines(i).point2[1]];
    end
end

