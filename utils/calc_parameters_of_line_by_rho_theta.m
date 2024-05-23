function [k, b] = calc_parameters_of_line_by_rho_theta(rho, theta)
    k = -cot(theta);
    b = rho / sin(theta);

end