function [points] = convert_lines_in_points(lines, countDivisionStep)
points = zeros([length(lines)*countDivisionStep 2]);
shiftInPoints = 0;

for i = 1:length(lines)
        [minX, maxX]= getMinMaxCoordinates(lines(i).point1(1), lines(i).point2(1));
        stepX = (maxX - minX) / countDivisionStep;
        curX = minX;

        [minY, maxY] = getMinMaxCoordinates(lines(i).point1(2), lines(i).point2(2));
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

function [min, max] = getMinMaxCoordinates(a, b)
    if a < b 
        min = a;
        max = b;
    else
        min = b;
        max = a;
    end

end