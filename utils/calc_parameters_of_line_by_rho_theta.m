function [k, b] = calc_parameters_of_line_by_rho_theta(rho, theta, x)
    k = -cot(theta);
    b = rho / sin(theta);
    
    % for vertical line
    if isinf(k) || isinf(b)
        k = 1000;
        b = -1 * x * 1000;
    end
end