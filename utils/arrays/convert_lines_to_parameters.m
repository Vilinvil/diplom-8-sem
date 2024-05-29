function [K, B, lines] = convert_lines_to_parameters(lines, maxY)
K = zeros([length(lines) 1]);
B = zeros([length(lines) 1]);

countLines = length(lines);
idxCurLine = 1;
    while idxCurLine <= countLines
        curLine = lines(idxCurLine);
        if get_len_line(curLine) > 0.4 * maxY
           [line1, line2] = divide_line_to_two_lines(curLine);
           curLine = line1;
           lines  = [lines, line2];
           K = [K; 0];
           B = [B; 0];

           countLines = countLines + 1; 
        end

        [curK, curB] = calc_parameters_of_line_by_rho_theta( ... 
            curLine.rho, curLine.theta * 2 * pi / 360, curLine.point1(1));
        K(idxCurLine) = curK;
        B(idxCurLine) = curB;

        idxCurLine = idxCurLine + 1; 
    end

end

function [line1, line2] = divide_line_to_two_lines(line)
    line1 = line;
    line2= line;
    
    stepX = (line.point2(1) - line.point1(1)) / 2;
    stepY = (line.point2(2) - line.point1(2)) / 2;

    line1.point2 = [line.point1(1) + stepX, line.point1(2) + stepY];
    line2.point1 = line1.point2;
end