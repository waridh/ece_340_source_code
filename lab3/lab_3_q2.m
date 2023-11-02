%% Question 2
% Clearing the figures and variables
clear; close all;

%% Question 2 a
% Getting the z-plane

% Transfer function 1

numera1 = [ 2 2 ];
denoma1 = [ 1 -1.25 ];

% Transfer function 2

numera2 = [2 2];
denoma2 = [1 -0.8];

% Obtaining the poles and zeros from the transfer functions
[zeros1, poles1] = tf2zpk(numera1, denoma1);
[zeros2, poles2] = tf2zpk(numera2, denoma2);

% Plotting the pole-zero plots
figure('Name', 'Question 2 a: H_1(z)', 'NumberTitle', 'off');
[hz1, hp1, ht1] = zplane(zeros1, poles1);
title("Pole-Zero plot of H_1(z)");

figure('Name', 'Question 2 a: H_2(z)', 'NumberTitle', 'off');
[hz2, hp2, ht2] = zplane(zeros2, poles2);
title("Pole-Zero plot of H_2(z)");

% Coloring

% Changing the axis color
set(findobj(ht1, 'Type', 'line'), 'Color', 'black', 'LineStyle', ':');
set(findobj(ht2, 'Type', 'line'), 'Color', 'black', 'LineStyle', ':');


% Changing the pole color
set(findobj(hp1, 'Type', 'line'), 'Color', 'red');
set(findobj(hp2, 'Type', 'line'), 'Color', 'red');

% Changing the zero color
set(findobj(hz1, 'Type', 'line'), 'Color', 'red');
set(findobj(hz2, 'Type', 'line'), 'Color', 'red');

%% Question 2b
% Plot the magnitude and the phase of the frequency response.
% Going to use the freqz function to calculate this.

% For H_1

[hh1, wh1] = freqz(numera1, denoma1, 'whole', 3000);

% For H_2

[hh2, wh2] = freqz(numera2, denoma2, 'whole', 3000);


% Plotting part b

% For the H_1 system
figure('Name', 'Question 2 b: H_1(e^{j\Omega})', 'NumberTitle', 'off');
tile = tiledlayout('vertical');
tile.TileSpacing = 'compact';
tile.Padding = 'compact';

% Plotting the magnitude
ax1 = nexttile;
p2b1 = plot(wh1, abs(hh1), "LineStyle", '-', 'Color', 'red');
xlabel(tile, "\Omega"); ylabel("|H_1(\Omega)|");
axis([0 2*pi -inf inf]);
xticks(0:pi/2:2*pi);
xticklabels({'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

% Plotting the phase
ax1b = nexttile;
p2b1b = plot(wh1, angle(hh1), "LineStyle", '-', 'Color', 'blue');
xlabel(tile, "\Omega"); ylabel("\angle H_1(\Omega)");
axis([0 2*pi -inf inf]);
xticks(0:pi/2:2*pi);
xticklabels({'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

% For the H_2 system.
figure('Name', 'Question 2 b: H_2(e^{j\Omega})', 'NumberTitle', 'off');
tile2 = tiledlayout('vertical');
tile2.TileSpacing = 'compact';
tile2.Padding = 'compact';

% Plotting the magnitude
ax2 = nexttile;
p2b2 = plot(wh2, abs(hh2), "LineStyle", '-', 'Color', 'black');
xlabel(tile2, "\Omega"); ylabel("|H_2(\Omega)|");
axis([0 2*pi -inf inf]);
xticks(0:pi/2:2*pi);
xticklabels({'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

% Plotting the phase
ax2b = nexttile;
p2b2b = plot(wh2, angle(hh2), "LineStyle", '-', 'Color', 'm');
xlabel(tile, "\Omega"); ylabel("\angle H_2(\Omega)");
axis([0 2*pi -inf inf]);
xticks(0:pi/2:2*pi);
xticklabels({'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

% Titles

[title1, subt1] = title(tile, "The frequency response of H_1(z)");
[title2, subt2] = title(tile2, "The frequency response of H_2(z)");

%% Question 2 c: impulse response function

% Setting up the sampling condition %
sampling_frequency = 1;
sampling_period = 1/sampling_frequency;
num_samples = 25;

% Creating the time vector (I am not going to hard code it)
start_time = 0;
end_time = start_time + (num_samples * sampling_period);
t = (start_time : sampling_period : end_time);

% Making the anonymous step functions for the signal
step1 = @(t) (0 <= t);
step2 = @(t) (1 <= t);

% Making the first signal using anonymous functions.
h1_aux1 = @(k) 2.*(1.25).^k;
h1_aux2 = @(k) 2.*(1.25).^(k-1);
h1_k = @(k) ( h1_aux1(k) .* step1(k) + h1_aux2(k) .* step2(k) );

% Making the second impulse response function
h2_aux1 = @(k) 2.*(0.8).^k;
h2_aux2 = @(k) 2.*(0.8).^(k-1);
h2_k = @(k) ( h2_aux1(k) .* step1(k) + h2_aux2(k) .* step2(k) );

% Begin plotting
f1 = figure('Name', 'Question 2. Impulse Response Function of H_1(z)', 'NumberTitle', 'off');
tile = tiledlayout('vertical');
tile.TileSpacing = 'compact';
tile.Padding = 'compact';

% The first signal plot
ax1 = nexttile;
s1 = stem(t, h1_k(t),'Marker','*', "LineStyle","-.");
s1.Color ='blue';
xlabel(tile, "k"); ylabel("h_1[k]");

% The second impulse response function
ax2 = nexttile;
s2 = stem(t, h2_k(t),'Marker','*', "LineStyle","-.");
s2.Color ='red';
ylabel("h_2[k]");

