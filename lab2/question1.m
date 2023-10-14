%% Clearing variables
close all;
clear;
%% Question 1
% Plotting two functions on the same page

% Setting up the sampling condition %
sampling_frequency = 1;
sampling_period = 1/sampling_frequency;
num_samples1i = 4; % Question 1i
num_samples1ii = 3;   % Question 1ii
num_samples1iii = num_samples1i + num_samples1ii; % Convolution case

% Creating the time vector (I am not going to hard code it)
start_time1i = 0;
start_time1ii = 0;
start_time1iii = start_time1i + start_time1ii -2; % Hand calculated
end_time1i = start_time1i + (num_samples1i * sampling_period);
end_time1ii = start_time1ii + (num_samples1ii * sampling_period);
end_time1iii = start_time1iii + (num_samples1iii * sampling_period);
t1i = (start_time1i : sampling_period : end_time1i);
t1ii = (start_time1ii : sampling_period : end_time1ii);
t1iii = (start_time1iii : sampling_period : end_time1iii);

% Making the anonymous step functions for the first signal
step1ia = @(t) (0 <= t);
step1ib = @(t) (t <= 4);
% This will create the range for function
step1i = @(t) step1ib(t).*step1ia(t);

% Making the first signal using anonymous functions.
x1_k = @(t) (step1i(t) .* t);

% Making the step function for the second signal
step1iia = @(t) (0 <= t);
step1iib = @(t) (t <= 3);
step1ii = @(t) step1iia(t).*step1iib(t);

% Making the second signal
h1_k = @(t) (2-t).*step1ii(t); % Final function

% Begin plotting
f1 = figure('Name', 'Question 1. Convolution', 'NumberTitle', 'off');
tile = tiledlayout('vertical');
tile.TileSpacing = 'compact';
tile.Padding = 'compact';
ax1 = nexttile;

% The first signal plot
s1 = stem(t1i, x1_k(t1i),'Marker','*');
s1.Color ='blue';
xlabel(tile, "k"); ylabel("x[k]");

% Real component of the second signal %
ax2 = nexttile;
s2 = stem(t1ii, h1_k(t1ii), 'Marker', '*');
s2.Color='red';
ylabel("h[k]");

%%  Question 1c
%   Convolution

y1_k = conv(x1_k(t1i), h1_k(t1ii));

ax3 = nexttile;
s3 = stem(t1iii, y1_k, 'Marker', '*');
s3.Color='black';
ylabel("y[k]");

% Adding subtitle for the plots
[title1, subt1] = title(ax1, "x[k]");
[title2, subt2] = title(ax2, "h[k]");
[title3, subt3] = title(ax3, "x[k]*h[k]");
