function dwt_coefficients=dwt_1D(data, scale)
% data: 1*N matrix, equal to a 1-D signal sequence
% scale: number of processing times
% dwt_coefficients: output the Haar wavelet coefficient
array_shape = size(data);
length = array_shape(2);
dwt_coefficients = data;

for i = 1:scale
    % obtain the receptive field in this iteration, shrinking every time
    wanted_length = length / (2^(i-1));
    repective_field = dwt_coefficients(1, 1:wanted_length);
    length_after = wanted_length/2;
    % group data with their neighborhoods
    repective_field_array = reshape(repective_field, 2, length_after);
    % computing the average by sum
    sum_1 = repective_field_array(1,:) + repective_field_array(2,:);
    % computing the difference by subtraction
    diff_1 = repective_field_array(1,:) - repective_field_array(2,:);
    repective_field(1:length_after) = sum_1;
    repective_field(length_after+1:wanted_length) = diff_1;
    dwt_coefficients(1, 1:wanted_length) = (repective_field) / 2;
end