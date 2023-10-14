%% Clearing variables and terminal
% Ran using MATLAB 2023b
close all;
clc;
clear;

%% Question 4a and b
% Reading from an image then writing to it as well

% Reading the image %
barbLarge = imread("barbaraLarge.jpg");
[im_sz_y, im_sz_x, im_sz_colour_fields] = size(barbLarge);

% Displaying the image
figure('Name', 'Original Barbara', 'NumberTitle','off');
tile = tiledlayout('flow');
tile.TileSpacing = 'compact'; tile.Padding = 'compact';
nexttile;
imshow(barbLarge), colorbar;

%% Question 4c
% Resizing the image down

resize_factor = [0.9, 0.7, 0.5];

barb_09 = imresize(barbLarge, resize_factor(1), 'nearest', ...
    'Antialiasing', false);
barb_07 = imresize(barbLarge, resize_factor(2), 'nearest', ...
    'Antialiasing', false);
barb_05 = imresize(barbLarge, resize_factor(3), 'nearest', ...
    'Antialiasing', false);

barbaa_09 = imresize(barbLarge, resize_factor(1), 'nearest', ...
    'Antialiasing', true);
barbaa_07 = imresize(barbLarge, resize_factor(2), 'nearest', ...
    'Antialiasing', true);
barbaa_05 = imresize(barbLarge, resize_factor(3), 'nearest', ...
    'Antialiasing', true);

figure('Name', 'Resized Barbara', 'NumberTitle','off');
tile = tiledlayout(3, 2);
tile.TileSpacing = 'compact'; tile.Padding = 'compact';

nexttile(1);
imshow(barb_09); title('Resized 0.9 Barbara');

nexttile(3);
imshow(barb_07); title('Resized 0.7 Barbara');

nexttile(5);
imshow(barb_05); title('Resized 0.5 Barbara');

nexttile(2);
imshow(barbaa_09); title('Resized 0.9 AA Barbara')

nexttile(4);
imshow(barbaa_07); title('Resized 0.7 AA Barbara')

nexttile(6);
imshow(barbaa_05); title('Resized 0.5 AA Barbara')

%% Question 4d
% Reducing the effects of aliasing using low-pass filter