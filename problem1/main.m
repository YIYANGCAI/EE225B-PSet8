% input
clear;
%test_data = [2, 5, 8, 9, 7, 4, -1, 1];
%scale = 2;
test_data = [1, 4, -3, 0];
scale = 2;

% DWT
code = dwt_1D(test_data, scale);
disp(code);
% inverse DWT
data = dwt_1D_inverse(code, scale);
disp(data);