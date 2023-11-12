%% Lab 4 Question 1

%% Clearing variables
close all;
clear;

%% Question 1 b

[x, fs] = audioread("love_mono22.wav"); % Loading song
bit_per_sample = 8;                     % 8 bit per sample.

fprintf('The size of the matrix is %s\n', mat2str(size(x)));
fprintf('The sampling rate is %dHz\n', fs);

% Finding the bitrate
bitrate = bit_per_sample * fs;  % Unit of bit/sec
fprintf('The bit rate is %dbit/sec\n', bitrate);

% Calculating the duration of the file
x_size= size(x);
num_samples = x_size(1);

duration = num_samples/fs;

fprintf('The duration of the audio file is %.3fsec\n', duration);

%% Question 2

% a
big_x_m = fft(x); % Obtaining the DFT of the love_mono22 file

% b
fprintf('X[0] = %.3f + j%0.3f\n', real(big_x_m(1)), imag(big_x_m(1)));
fprintf('X[1] = %.3f + j%0.3f\n', real(big_x_m(2)), imag(big_x_m(2)));
fprintf('X[2] = %.3f + j%0.3f\n', real(big_x_m(3)), imag(big_x_m(3)));

% c
big_x_m_prime = (big_x_m) ./ sqrt(num_samples);

% d

the_r = 0:1:(num_samples- 1); % Matching all the samples
corresponding_freq = (fs/num_samples) .* the_r; % Converted the freq

% Plotting the DFT.
figure('Name', 'Question 2 d: Xprime', 'NumberTitle', 'off');
tile2 = tiledlayout('vertical');
tile2.TileSpacing = 'compact';
tile2.Padding = 'compact';

% Plotting the magnitude
ax2 = nexttile;
p2b2 = plot(corresponding_freq, 20.*log10(abs(big_x_m_prime)), ...
  "LineStyle", '-', 'Color', 'black');
xlabel(tile2, "F (kHz)"); ylabel("X'[r] (dB)");
axis([corresponding_freq(1) corresponding_freq(num_samples) -inf inf]);
xticks(0:2000:corresponding_freq(num_samples));
xticklabels(0:2:corresponding_freq(num_samples)/1000);

% Question 3

N = 512;
[Px, F] = pwelch(x, N, [], N, fs);
figure('Name', 'Question 3a: power spectral density', ...
  'NumberTitle', 'off');
plot(F/1000, 10*log10(Px), 'Color', 'blue'); % Plotting power spec
axis([Px(1) fs/2000 -inf inf]);
xlabel('Frequency (kHz)');
ylabel('Power Spectral Density (in dB)');

