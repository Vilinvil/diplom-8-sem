function figure_classificated_points(points, classIdxes, numberClasses)
    pointsColor = rand(numberClasses, 3);
    for idxPoint = 1:length(points)
        curClassIdx = classIdxes(idxPoint);
        plot(points(idxPoint,1),points(idxPoint,2),'k*','MarkerSize',5, 'Color', [pointsColor(curClassIdx, 1) ...
            pointsColor(curClassIdx, 2) pointsColor(curClassIdx, 3)]);
    end

end