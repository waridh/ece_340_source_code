% Lab 3 Question 1

%% Clearing variables
close all;
clear;
%% Question 1

% Setting up the sampling condition %
sampling_frequency = 1;
sampling_period = 1/sampling_frequency;
num_samples1 = 10;

% Creating the time vector (I am not going to hard code it)
start_time1 = 0;
end_time1 = start_time1 + (num_samples1 * sampling_period);
t1 = (start_time1 : sampling_period : end_time1);

% Making the anonymous step functions for the first signal
step1a = @(t) (0 <= t);

% This will create the range for function
step1 = @(t) step1a(t);

% Making the first signal using anonymous functions.
x1_aux1 = @(k) k.*(0.5).^k;
x1_aux2 = @(k) sin((pi/6).*k);
x1_k = @(t) (step1(t) .* x1_aux1(t) .* x1_aux2(t) );

% Begin plotting
f1 = figure('Name', 'Question 1. Causal Linear Filter', 'NumberTitle', 'off');
tile = tiledlayout('vertical');
tile.TileSpacing = 'compact';
tile.Padding = 'compact';
ax1 = nexttile;

% The first signal plot
s1 = stem(t1, x1_k(t1),'Marker','*', "LineStyle","-.");
s1.Color ='blue';
xlabel(tile, "k"); ylabel("h_1[k]");

% Adding subtitle for the plots
[title1, subt1] = title(ax1, "h_1[k]");

%% Part c

numera = [0 0.25 0 -0.0625 0];
denoma = [1 -sqrt(3) 1.25 -sqrt(3)/4 0.0625];
input = zeros(1, 11);
input(1) = 1;

h2_k = filter(numera, denoma, input );

ax2 = nexttile;
% The second plot
s2 = stem(t1, h2_k,'Marker','*', 'LineStyle', '--');
s2.Color ='black';
ylabel("h_2[k]");

ax3 = nexttile;
% The plot of the input to the filter
s3 = stem(t1, input, 'Marker', '*');
s3.Color = 'red';
ylabel("\delta[k]");

% Adding subtitle for the plots
[title2, subt2] = title(ax2, "h_2[k]");
[title3, subt3] = title(ax3, "\delta[k]");
