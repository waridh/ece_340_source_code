%% Question 3

close all; clear;

%% Part c
%  Reading the audio file early so that the sampling frequency updates

[love_mono, Fs] = audioread('love_mono22.wav');

%% Part a

wc = [0.26 0.286]; % This is the band stop range. Hard-coded range for now

window = hamming(513);
% Truncation window function, using Hamming window.
% Other truncation window types may also be applicable. Please use
% Matlab help to find more applicable truncation windows.
filter_coeff= fir1(513-1, wc, 'stop', window);
% filter_coeff: Coefficients of the FIR filter

%% Part b

freqz(filter_coeff, 1);   % The frequency response of the filter

% Changing the color of the series
lines = findall(gcf, 'type', 'line');
lines(1).Color = 'r';
lines(2).Color = 'r';

%% Part d

love_mono_filtered = filter(filter_coeff, 1, love_mono);

%% Part e

figure; % This is the original file PSD
pwelch(love_mono);
lines = findall(gcf, 'type', 'line');
lines(1).Color = 'black';

figure; % This is the filtered output
pwelch(love_mono_filtered);
lines = findall(gcf, 'type', 'line');
lines(1).Color = 'm';

%% Part f
%  Just saving the filtered audio signal into a file

audiowrite("love_mono22_filtered_3.wav", love_mono_filtered, Fs);
