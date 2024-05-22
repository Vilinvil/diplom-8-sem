function [points] = convert_lines_in_points_evenly(lines, maxDiff)
    if isempty(lines)
        points = [];
        return
    end   

    addpath("utils");
    points = [];
    floatComparaisonAccuracy = 10^(-2);

    for i = 1:length(lines)
        % [minX, maxX]= get_min_max(lines(i).point1(1), lines(i).point2(1));
        curX = lines(i).point1(1);
        expectedX = lines(i).point2(1);

        % [minY, maxY] = get_min_max(lines(i).point1(2), lines(i).point2(2));
        curY = lines(i).point1(2);
        expectedY = lines(i).point2(2);

        [stepX, stepY] = findDivisionSteps(curX, expectedX, curY, expectedY, maxDiff);
        
        while (abs(curX - expectedX) > floatComparaisonAccuracy) && ...
                (abs(curY - expectedY) > floatComparaisonAccuracy)

            points = [points ; [curX, curY]];

            curX = curX + stepX;
            curY = curY + stepY;
        end

        points = [points ; [curX, curY]];
    end 
end

function [stepX, stepY] = findDivisionSteps(curX, expectedX, curY, expectedY, maxDiff)
  amountDivisionStep = 2;
  stepX = (expectedX - curX) / amountDivisionStep;
  stepY = (expectedY - curY) / amountDivisionStep;

  while ((stepX^2 + stepY^2)^(1/2) >= maxDiff)
    amountDivisionStep = amountDivisionStep + 1; 
      stepX = (expectedX - curX) / amountDivisionStep;
      stepY = (expectedY - curY) / amountDivisionStep;
  end
end