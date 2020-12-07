function data=dwt_2D_inverse(dwt_coefficients, scale)
% input: a 2_D image data's dwt cofficient
% scale: the number of processing times
img_shape = size(dwt_coefficients);
h = img_shape(1);
w = img_shape(2);
data = dwt_coefficients;

for s = flip(1 : scale)
    wanted_index = h / 2 ^ (s - 1);
    processing_area = data(1:wanted_index, 1:wanted_index);
    % process with column
    for j = 1 : wanted_index
        processing_area(:,j) = (dwt_1D_inverse((processing_area(:,j))', 1))';
    end
    % process with row
    for i = 1 : wanted_index
        processing_area(i,:) = dwt_1D_inverse(processing_area(i,:), 1);
    end
    data(1:wanted_index, 1:wanted_index) = processing_area;
end

