function [k,b] = calc_parameters_of_line(point1, point2)
A = [point1(1) 1; point2(1) 1];
B = [point1(2); point2(2)]

result = lsqr(A, B);
k = result(1,1)
b = result(2, 1)

end