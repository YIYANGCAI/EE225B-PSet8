clear;
close all;
clc;

% read in the image, obtain the parameters
img = imread('./Fig2.4.jpg');
img = im2double(img);
% img = imresize(img, 0.5);
% img_new = zeros(256);
% img_new(4:253, 4:253) = img;
% img = img_new;
% figure;
imshow(img);title('input image');
img_shape = size(img);
h = img_shape(1);
w = img_shape(2);
scale = 8;

for s = 1 : scale
    % DWT 2D
    code = dwt_2D(img, s);
    figure;
    subplot(1,3,1);
    imshow(code);title('dwt transform');
    
    % scaling-based visualization
    image_vis = zeros(h, w);
    splitting_index = w / (2 ^ s);
    image_vis((splitting_index+1):h, :) = code((splitting_index+1):h, :);
    image_vis(:, (splitting_index+1):w) = code(:, (splitting_index+1):w);
    max_v = max(max(image_vis));
    min_v = min(min(image_vis));
    image_vis = (image_vis - min_v) / (max_v - min_v);
    image_vis(1:splitting_index, 1:splitting_index) = code(1:splitting_index, 1:splitting_index);
    subplot(1,3,2);
    imshow(image_vis);title('dwt transform with scaling');
    
    % using a threshold to truncate the original code
    threshold = 0.025;
    new_code = zeros(h);
    for i = 1 : h
        for j = 1 : w
            if abs(code(i,j)) <= threshold
                new_code(i,j) = 0;
            else
                new_code(i,j) = code(i,j);
            end
        end
    end
    % place the approximation coefficients
    new_code(1:splitting_index, 1:splitting_index) = code(1:splitting_index, 1:splitting_index);

    % DWT 2D inverse
    image_reconstructed = dwt_2D_inverse(new_code, s);
    subplot(1,3,3);
    imshow(image_reconstructed);title('image reconstructed');
    %img = code;
    r1 = SQAR_SNR(image_reconstructed, img);
    r2 = RMSE(image_reconstructed, img);
    fprintf('Scale %d, SQAR_SNR: %f, RMSE: %f\n', s, r1, r2);
end
