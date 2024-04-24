function [points] = convert_lines_in_points(lines, countDivisionStep)
addpath('utils');
points = zeros([length(lines)*countDivisionStep 2]);
shiftInPoints = 0;

for i = 1:length(lines)
        [minX, maxX]= get_min_max(lines(i).point1(1), lines(i).point2(1));
        stepX = (maxX - minX) / countDivisionStep;
        curX = minX;

        [minY, maxY] = get_min_max(lines(i).point1(2), lines(i).point2(2));
        stepY = (maxY - minY) / countDivisionStep;
        curY = minY;

        for idxInside = 1:countDivisionStep 
            points(idxInside + shiftInPoints, :) = [curX, curY];

            curX = curX + stepX;
            curY = curY + stepY;
        end

        shiftInPoints = shiftInPoints + countDivisionStep;

end

    if isempty(lines)
        points = [];
    end    
end