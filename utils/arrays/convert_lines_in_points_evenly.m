function [points] = convert_lines_in_points_evenly(lines, maxDiff)
    if isempty(lines)
        points = [];
        return
    end   

    addpath("utils");
    points = [];

    for i = 1:length(lines)
        [minX, maxX]= get_min_max(lines(i).point1(1), lines(i).point2(1));
        curX = minX;

        [minY, maxY] = get_min_max(lines(i).point1(2), lines(i).point2(2));
        curY = minY;

        [stepX, stepY] = findDivisionSteps(minX, maxX, minY, maxY, maxDiff);
        
        while (curX <= maxX) && (curY <= maxY)
            points = [points ; [curX, curY]];

            curX = curX + stepX;
            curY = curY + stepY;
        end
    end 

    % points = points(1,:);
end

function [stepX, stepY] = findDivisionSteps(minX, maxX, minY, maxY, maxDiff)
  amountDivisionStep = 2;
  stepX = (maxX - minX) / amountDivisionStep;
  stepY = (maxY - minY) / amountDivisionStep;
  while ((stepX^2 + stepY^2)^(1/2) >= maxDiff)
    amountDivisionStep = amountDivisionStep + 1; 
      stepX = (maxX - minX) / amountDivisionStep;
      stepY = (maxY - minY) / amountDivisionStep;
  end
end