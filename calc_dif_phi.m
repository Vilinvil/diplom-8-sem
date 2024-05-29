function [difPhi] = calc_dif_phi(image, cannySigma, cannyThreshold,... 
    houghParams, epsDbscan)

    [lines, blackWhiteImage] = get_borders_lines( ...
        image,  cannySigma, cannyThreshold, houghParams);
    
    figure, imshow(blackWhiteImage),title('После выделения отрезков'), hold on;
    figure_lines_by_two_points(lines);
    
    maxY = size(blackWhiteImage, 2);
    [K, B, lines] = convert_lines_to_parameters(lines, maxY);
    
    phi = atan(K);
    normB = norm_with_remove_inf(B);
    lineParameters = [phi, normB];
    
    minCountNeighbors = 2;
    [DbscanLinesClassIdxess, DbscanLinesNumberClasses, DbscanFlagExistenceMinus] = ... 
        clasterization_dbscan_lines(lineParameters, epsDbscan, minCountNeighbors);
    
    
    figure, imshow(blackWhiteImage),title('Метод dbscan lines, число классов=' + ...
        string(DbscanLinesNumberClasses) + ' Eсть ли не классифицированные=' + ...
        string(DbscanFlagExistenceMinus)), hold on;
    figure_classificated_lines_by_parametrs(K, B, maxY, ...
        DbscanLinesClassIdxess, DbscanLinesNumberClasses);
    
    lengths = convert_lines_to_lengths(lines);
    % if DbscanFlagExistenceMinus
    %     lengths = set_zero_length_to_not_classificated(... 
    %         DbscanLinesClassIdxess, DbscanLinesNumberClasses, lengths);
    % end
    
    thresholdHighPhi = 30 * pi / 180; 
    
    [kAxis, bAxis, k1, b1, k2 , b2] = detect_axis_of_symmetry(lengths, K, B, ... 
        DbscanLinesClassIdxess, DbscanLinesNumberClasses, thresholdHighPhi);
    figure, imshow(blackWhiteImage),title('Ось трубопровода'), hold on;
    figure_lines_by_parameters(kAxis, bAxis, maxY, 'red');
    figure_lines_by_parameters(k1, b1, maxY, 'green');
    figure_lines_by_parameters(k2, b2, maxY, 'green');
    
    phiAxis = atan(kAxis);
    if phiAxis < 0
        phiAxis = phiAxis + pi;
    end

    difPhi = phiAxis - pi / 2;
end