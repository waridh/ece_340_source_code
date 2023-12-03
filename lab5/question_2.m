%% Question 2

close all; clear;

%% Part c
%  Reading the audio file early so that the sampling frequency updates

[love_mono, Fs] = audioread('love_mono22.wav');

%% Part a

fc = 5000; % Hertz. fc is the cut-off frequency of the filter

wc=fc/(Fs/2);

% Fs: Sampling frequency of the audio signal
window = hamming(513);
% Truncation window function, using Hamming window.
% Other truncation window types may also be applicable. Please use
% Matlab help to find more applicable truncation windows.
filter_coeff= fir1(513-1, wc, 'high', window);
% filter_coeff: Coefficients of the FIR filter

%% Part b

freqz(filter_coeff, 1);   % The frequency response of the filter

% Changing the color of the series
lines = findall(gcf, 'type', 'line');
lines(1).Color = 'm';
lines(2).Color = 'm';

%% Part d

love_mono_filtered = filter(filter_coeff, 1, love_mono);

%% Part e

figure;
pwelch(love_mono);
lines = findall(gcf, 'type', 'line');
lines(1).Color = 'blue';

figure;
pwelch(love_mono_filtered);
lines = findall(gcf, 'type', 'line');
lines(1).Color = 'blue';

%% Part f
%  Just saving the filtered audio signal into a file

audiowrite("love_mono22_filtered_hp.wav", love_mono_filtered, Fs);
