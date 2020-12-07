clear;
close all;
clc;

% read in the image, obtain the parameters
img = imread('./Fig2.3.jpg');
img = im2double(img);
img = imresize(img, 0.5);
img_new = zeros(256);
img_new(4:253, 4:253) = img;
img = img_new;
figure;
imshow(img);title('input image');
img_shape = size(img);
h = img_shape(1);
w = img_shape(2);
scale = 8;

for s = 1 : scale
    % DWT 2D
    code = dwt_2D(img, s);
    figure;
    subplot(1,4,1);
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
    subplot(1,4,2);
    imshow(image_vis);title('dwt coefficients with scaling');
    
    % zero the horizontal area
    for s2 = 1 : s
        index = splitting_index*(2^(s2-1));
        code(1:index, index+1:index*2) = 0;
        code(index+1:index*2, 1:index) = 0;
    end
    image_vis = zeros(h, w);
    splitting_index = w / (2 ^ s);
    image_vis((splitting_index+1):h, :) = code((splitting_index+1):h, :);
    image_vis(:, (splitting_index+1):w) = code(:, (splitting_index+1):w);
    max_v = max(max(image_vis));
    min_v = min(min(image_vis));
    image_vis = (image_vis - min_v) / (max_v - min_v);
    image_vis(1:splitting_index, 1:splitting_index) = code(1:splitting_index, 1:splitting_index);
    subplot(1,4,3);
    imshow(image_vis);title('dwt transform with scaling, zero approximation');
    

    % DWT 2D inverse
    image_reconstructed = dwt_2D_inverse(code, s);
    subplot(1,4,4);
    imshow(image_reconstructed);title('reconstructed image');
    %img = code;
    
end