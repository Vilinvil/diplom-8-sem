function [k, b] = calc_parameters_axis_of_symmetry(k1, k2, b1, b2)
k = tan(atan(k1)+atan((k2-k1)/1+k1*k2)/2);
b = (k1-k)*(b1-b2)/(k2-k1) + b1;
end