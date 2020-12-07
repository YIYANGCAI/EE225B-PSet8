function data=dwt_1D_inverse(dwt_coefficients, scale)
% function processing
array_shape = size(dwt_coefficients);
length = array_shape(2);
data = dwt_coefficients;

for i = flip(1:scale)
    % %dwt original process, as a reference of writing the inverse function
    %-------------
    % %obtain the receptive field in this iteration, shrinking every time
    % wanted_length = int8(length / (2^(i-1)));
    % repective_field = dwt_coefficients(1, 1:wanted_length);
    % length_after = wanted_length/2;
    % %group data with their neighborhoods
    % repective_field_array = reshape(repective_field, 2, length_after);
    % sum_1 = repective_field_array(1,:) + repective_field_array(2,:);
    % diff_1 = repective_field_array(1,:) - repective_field_array(2,:);
    % repective_field(1:length_after) = sum_1;
    % repective_field(length_after+1:wanted_length) = diff_1;
    % dwt_coefficients(1, 1:wanted_length) = (repective_field) / sqrt(2);
    %-------------
    wanted_length = length / (2^(i-1));
    repective_field = data(1, 1:wanted_length) * 2;
    length_before = wanted_length/2;
    repective_field_array = reshape(repective_field, length_before, 2);
    % reconstruct the data based on sum and difference
    A = (repective_field_array(:,1) + repective_field_array(:,2))/2;
    B = (repective_field_array(:,1) - repective_field_array(:,2))/2;
    repective_field = reshape([A,B]', 1, wanted_length);
    data(1:wanted_length) = repective_field;
    %disp(data);
    
end