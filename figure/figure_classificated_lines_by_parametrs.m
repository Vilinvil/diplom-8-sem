function figure_classificated_lines_by_parametrs(K, B, maxY, classIdxes, numberClasses)
    linesColor = rand(numberClasses, 3);
    % difColor = 1 / numberClasses;
    for idxLine = 1:length(K)
        curClassIdx = classIdxes(idxLine);
        figure_lines_by_parameters(K(idxLine), B(idxLine), ...
            maxY, linesColor(curClassIdx,:))
        % plot(points(idxLine,1),points(idxLine,2),'k*','MarkerSize',5, 'Color', [ 0 0 difColor * curClassIdx]);
    end

    figure, hold on;
    for curClassIdx = 1:numberClasses
        plot(0, curClassIdx, 'k*','MarkerSize',5, 'Color', linesColor(curClassIdx,:));
        % plot(0, curClassIdx, 'k*','MarkerSize',5, 'Color', [ 0 0 difColor * curClassIdx]);
        text(0, curClassIdx, sprintf('   idx %s', string(curClassIdx)));
    end
end