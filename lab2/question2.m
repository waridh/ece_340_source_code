%% Clearing variables
close all;
clear;
%% Question 2
% Plotting two functions on the same page

% Setting up the sampling condition %
sampling_frequency = 1;
sampling_period = 1/sampling_frequency;
num_samples2 = 50; % Question 2

% Creating the time vector (I am not going to hard code it)
start_time2 = 0;
end_time2 = start_time2 + (num_samples2 * sampling_period);
t2 = (start_time2 : sampling_period : end_time2);

% Making the anonymous step functions for the first signal
step2a = @(t) (0 <= t);
step2b = @(t) (t <= 50);
% This will create the range for function
step2 = @(t) step2b(t).*step2a(t);

% Making the first signal using anonymous functions.
h2a_k = @(t) 0.3.*sinc((0.3.*(t-25)));
h2b_k = @(t) (0.54 - 0.46.*cos((2.*pi.*t)/(50)));
h2_k = @(t) (step2(t) .* h2b_k(t) .* h2a_k(t));

% Getting matrix x3 again
audio_filename = 'baila.wav';
[x3_aux, fs_audio] = audioread(audio_filename); % Read the songfile

x3 = x3_aux.';  % Transposing the array to match the format of other funcs
ts_audio = 1/fs_audio;  % Calculating period

numsamples_x3 = length(x3); % Getting the number of samples

end_time_x3 = numsamples_x3*ts_audio;   % Calculating when the song ends

time_vector_x3 = (0 : ts_audio : (end_time_x3-ts_audio));

x3_filtered = conv(x3, h2_k(t2));

% Begin plotting
f2 = figure('Name', 'Question 2', 'NumberTitle', 'off');

% The first signal plot
s1 = stem(t2, h2_k(t2),'Marker','*');
s1.Color ='blue';
xlabel("k"); ylabel("h[k]");
% Adding subtitle for the plots
title("h[k]");

%%  Question 2d
%   Store the output in a file

audio_out_name = 'baila_filtered.wav';
audiowrite(audio_out_name, x3_filtered, fs_audio);




