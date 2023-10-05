%% Clearing variables and terminal
% Ran using MATLAB 2023a
clc;
clear;

%% General anonymous functions
% These are functions that are used by multiple question sections.

% This function will only return 1 when the t is a multiple of the period.
period_check = @(t, initial_value, period) (mod((t-initial_value), ...
    period) == 0);
% This function compares two array and produce a new array where condit
% array and main array intersects
index_filter = @(main_array, condit_array) (main_array(condit_array == 1));

%% Question 1 Generation and Plotting
% Plotting two functions on the same page

% Setting up the sampling condition %
sampling_frequency = 1;
sampling_period = 1/sampling_frequency;
num_samples1i = 50; % Question 1i
num_samples1ii = 100;   % Question 1ii

% Creating the time vector (I am not going to hard code it)
start_time1i = -10;
start_time1ii = 0;
end_time1i = start_time1i + (num_samples1i * sampling_period);
end_time1ii = start_time1ii + (num_samples1ii * sampling_period);
t1i = (start_time1i : sampling_period : end_time1i);
t1ii = (start_time1ii : sampling_period : end_time1ii);

% Making the anonymous step functions for the first signal
step1ia = @(t) (-10 <= t);
step1ib = @(t) (t <= 40);
% This will create the range for function
step1i = @(t) step1ib(t).*step1ia(t);

% Making the first signal using anonymous functions. Building via subfuncs
dtfunc1ia = @(t) (0.1*pi).*t - ((3*pi)/4);
dtfunc1ib = @(t) ((0.4*pi).*t);
dtfunc1ic = @(t) (-5.1)*sin(dtfunc1ia(t)) + (1.1).*cos(dtfunc1ib(t));
dtfunc1i = @(t) step1i(t).*dtfunc1ic(t);    % The full function form

% Making the periodic indicator for 1i
period_xline = @(t) (index_filter(t, period_check(t,-2, 20)));

% Making the step function for the second signal
step1iia = @(t) (0 <= t);
step1iib = @(t) (t <=100);
step1ii = @(t) step1iia(t).*step1iib(t);

% Making the second signal
dtfunc1iia = @(t) (-0.9).^t;
dtfunc1iib = @(t) (((1i*pi).*t)./10);
dtfunc1iic = @(t) dtfunc1iia(t).*exp(dtfunc1iib(t));
dtfunc1ii = @(t) dtfunc1iic(t).*step1ii(t); % Final function

% Begin plotting
f1 = figure('Name', 'Question 1', 'NumberTitle', 'off');
tile = tiledlayout('vertical');
tile.TileSpacing = 'compact';
tile.Padding = 'compact';
title(tile, "Q.1 Signal Generation and Plotting");
ax1 = nexttile;

% The first signal plot
s1 = stem(t1i, dtfunc1i(t1i),'Marker','.');
% Placing periodic vertical lines
xline(period_xline(t1i), '-.m', 'Period', 'LabelHorizontalAlignment', ...
    'center', 'LabelOrientation',"horizontal");
s1.Color ='blue';
xlabel(tile, "k"); ylabel("x_1[k]");

% Real component of the second signal %
ax2 = nexttile;
outii = real(dtfunc1ii(t1ii));
s2 = stem(t1ii, outii, 'Marker', '.');
s2.Color='red';
ylabel("re(x_2[k])");


% Imaginary component of the second signal %
ax3 = nexttile;
s3= stem(t1ii, imag(dtfunc1ii(t1ii)), 'Marker', '.');
s3.Color='magenta';
ylabel("im(x_2[k])");

linkaxes([ax2, ax3], 'x');  % Linking both the real and imaginary component

%%  Question 1c
%   The goal here is to find the total energy of signal x1[k] and x2[k]
%   The total energy of a signal is the
%   \sum_{k=-\infty}^{\infty}\left|x[k]\right|^2
%   We can make an anonymous function that will do the operation on all
%   element of the matrix, and then sum all those elements. This will be
%   fast.

% Squaring all the absolute values of the array
total_energy_calc_aux1 = @(t) ( abs( t ) .^ 2);
% Calculating the total energy of all the entries of an input array
total_energy_calc = @(t) (sum(total_energy_calc_aux1(t), "all"));

% Calculating the total energy of all three signals
x1_tot_energy = @(t) total_energy_calc(dtfunc1i(t));
x2_re_tot_energy = @(t) total_energy_calc(real(dtfunc1ii(t)));
x2_im_tot_energy = @(t) total_energy_calc(imag(dtfunc1ii(t)));

% Generating the subtitle
subtitle_gen_periodic = @(period, tot_energy) ( ...
    ['Signal is periodic with period T = ' num2str(period) ...
    ', Total energy = ' num2str(tot_energy)]);
subtitle_gen_aperiodic = @(tot_energy) ( ...
    ['Signal is aperiodic, Total energy = ' num2str(tot_energy)]);

% Adding subtitle for the plots
[title1, subt1] = title(ax1, "x_1[k]", subtitle_gen_periodic(20, ...
    x1_tot_energy(t1i)));
[title2, subt2] = title(ax2, "Real component of x_2[k]", ...
    subtitle_gen_aperiodic(x2_re_tot_energy(t1ii)));
[title3, subt3] = title(ax3, "Imaginary component of x_2[k]", ...
    subtitle_gen_aperiodic(x2_im_tot_energy(t1ii)));

%% Question 2
%   This is question 2 where we input an audio signal and then do some
%   analysis of the signal. Also outputting half size signal back out to
%   the file system.

% Making a subtitle generator. Might not have been needed, but done now.
subtitle_gen_x3 = @(tot_energy) (['Total energy = ' num2str(tot_energy)]);

audio_filename = 'baila.wav';
[x3_aux, fs_audio] = audioread(audio_filename); % Read the songfile

x3 = x3_aux.';  % Transposing the array to match the format of other funcs
ts_audio = 1/fs_audio;  % Calculating period

numsamples_x3 = length(x3); % Getting the number of samples

end_time_x3 = numsamples_x3*ts_audio;   % Calculating when the song ends

time_vector_x3 = (0 : ts_audio : (end_time_x3-ts_audio));

x3_tot_energy = total_energy_calc(x3);  % Reusing function to calc the TE

x3s = x3(:, 1:(numsamples_x3/2));   % Grabbing half the sample in x3s

% Writing to a file %
audio_out_name = 'baila_half.wav';
audiowrite(audio_out_name, x3s, fs_audio);

%% Question 2 Plotting
f2 = figure('Name', 'Question 2', 'NumberTitle', 'off');
q2plot = stem(time_vector_x3, x3, 'Marker', '.', 'MarkerSize', 1, ...
    'Color', 'b');
xlabel("amplitude"); ylabel("time (s)");
title("x3(t)", subtitle_gen_x3(x3_tot_energy));

%% Question 3
% Reading from an image then writing to it as well

% Reading the image %
vase = imread("vase.jpg");
[im_sz_y, im_sz_x, im_sz_colour_fields] = size(vase);
vase_bright = vase + 30;    % Increasing the brightness of the image
brightest_pixel = max(max(vase_bright));
brightest_vase_pixel = max(max(vase));
imwrite( vase_bright ,'vase_bright.jpg','jpg','Quality', 100);

%% Question 4
% Runs the system response for the fourth question and then plots the
% response

q4_k = 0:49;    % This is the x axis
q4_xk = ones(1, 50);    % This is the x[k] unit step function input

q4_a1 = 0.5; q4_a2 = 2; % These are the two cases that are being used

% Making the figure for the plot
f3 = figure('Name', 'Question 4', 'NumberTitle', 'off');
tile2 = tiledlayout('vertical');
tile2.TileSpacing = 'compact';
tile2.Padding = 'compact';
title(tile2, "Q.4 System Response");

% The first signal
ax41 = nexttile;
s41 = stem(q4_k, sysresp(q4_xk,0.5),'Marker','.');
s41.Color ='blue';
xlabel(tile, "k"); ylabel("y_1[k]");

% The second signal %
ax42 = nexttile;
s42 = stem(q4_k, sysresp(q4_xk,2), 'Marker', '.');
s42.Color='red';
ylabel("y_2[k]");

% The third signal of my choosing %
ax43 = nexttile;
s43 = stem(q4_k, sysresp(q4_xk,0.9), 'Marker', '.');
s43.Color='magenta';
ylabel("y_2[k]");

[title41, subt41] = title(ax41, "i. System Response with a = 0.5", ...
    'This system is stable. y[k] converges, thus BIBO');
[title42, subt42] = title(ax42, "ii. System Response with a = 2", ...
    'This system is not stable. y[k] keeps growing, thus not BIBO');

[title43, subt43] = title(ax43, "c. System Response with a = 0.9", ...
    'This system is stable. y[k] converges, thus BIBO');
