function figure_classificated_points(points, classIdxes, numberClasses)
    pointsColor = rand(numberClasses, 3);
    % difColor = 1 / numberClasses;
    for idxPoint = 1:length(points)
        curClassIdx = classIdxes(idxPoint);
        plot(points(idxPoint,1),points(idxPoint,2),'k*','MarkerSize',5, 'Color', pointsColor(curClassIdx,:));
        % plot(points(idxPoint,1),points(idxPoint,2),'k*','MarkerSize',5, 'Color', [ 0 0 difColor * curClassIdx]);
    end

    figure, hold on;
    for curClassIdx = 1:numberClasses
        plot(0, curClassIdx, 'k*','MarkerSize',5, 'Color', pointsColor(curClassIdx,:));
        % plot(0, curClassIdx, 'k*','MarkerSize',5, 'Color', [ 0 0 difColor * curClassIdx]);
        text(0, curClassIdx, sprintf('   idx %s', string(curClassIdx)));
    end
end
