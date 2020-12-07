function dwt_coefficients=dwt_2D(data, scale)
% input: a 2_D image data
% scale: the number of processing times
img_shape = size(data);
h = img_shape(1);
w = img_shape(2);
dwt_coefficients = data;

% process with row
for s = 1 : scale
    % obtain the area for current scale to process
    % every time the processing area is the approximate area of the last one.
    wanted_index = h / 2 ^ (s - 1);
    processing_area = dwt_coefficients(1:wanted_index, 1:wanted_index);
    for i = 1 : wanted_index
        processing_area(i,:) = dwt_1D(processing_area(i,:), 1);
    end
    % process with column, pay attention to transpose (original 1-D is for row vectors)
    for j = 1 : wanted_index
        processing_area(:,j) = (dwt_1D((processing_area(:,j))', 1))';
    end
    dwt_coefficients(1:wanted_index, 1:wanted_index) = processing_area;
end