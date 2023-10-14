%% Clearing variables
close all;
clear;
%% Signals
x1_k = @(t) cos((20.* pi).* t);
x2_k = @(t) cos((180 .* pi).* t);
x3_k = @(t) cos((380 .* pi) .* t);

%% Question 3a
% Sampling analog sine wave with 100 Hz sampling rate.

% Setting up the sampling condition %
sampling_frequency3a = 100;
sampling_period3a = 1/sampling_frequency3a;
num_samples3a = 30; % Question 3a


% Creating the time vector
start_time3a = 0;

% ending time calculation
end_time3a = start_time3a + (num_samples3a * sampling_period3a);

% Creating the actual time vector
t3a = (start_time3a : sampling_period3a : end_time3a);


% Making the anonymous step functions for part a
step3aa = @(t) (0 <= t);
step3ab = @(t) (t <= 30);

% This will create the range for function
step3a = @(t) step3aa(t).*step3ab(t);

% Generating the sinusoid that was sampled.
x1_k3a = @(t) step3a(t) .* x1_k(t);
x2_k3a = @(t) step3a(t) .* x2_k(t);
x3_k3c = @(t) step3a(t) .* x3_k(t);

% Begin plotting
f1 = figure('Name', 'Question 3a', 'NumberTitle', 'off');
tile = tiledlayout('vertical');
tile.TileSpacing = 'compact';
tile.Padding = 'compact';
ax1 = nexttile;

% The first signal plot
s1 = stem(0 : 30, x1_k3a(t3a),'Marker','*', 'MarkerSize', 5);
s1.Color ='blue';
xlabel(tile, "n"); ylabel("y_1[n]");

% The second sinusoidal
ax2 = nexttile;
s2 = stem(0:30, x2_k3a(t3a), 'Marker', '*', 'MarkerSize', 5);
s2.Color='red';
ylabel("y_2[n]");

% A third sinusoidal signal that will show up identically to the first one.
% This value was found by multiplying the second sinusoidal wave with 9.
ax5 = nexttile;
s5 = stem(0:30, x3_k3c(t3a), 'Marker', '*', 'MarkerSize', 5);
s5.Color='black';
ylabel("y_3[n]");

%% Question 3b
% Sampling analog sine wave with 1000 Hz sampling rate.

% Setting up the sampling condition %
sampling_frequency3b = 1000;
sampling_period3b = 1/sampling_frequency3b;
num_samples3b = 300; % Question 3b


% Creating the time vector
start_time3b = 0;

end_time3b = start_time3b + (num_samples3b * sampling_period3b);

t3b = (start_time3b : sampling_period3b : end_time3b);


% Making the anonymous step functions for part b 0 <= n <= 300
step3ba = @(t) (0 <= t);
step3bb = @(t) (t <= 300);

% This will create the range for function
step3b = @(t) step3ba(t).*step3bb(t);

x1_k3b = @(t) step3b(t) .* x1_k(t);
x2_k3b = @(t) step3b(t) .* x2_k(t);

%% Plotting them together
% This section follows a the example code, but uses tile layout instead of
% subplots. This gives greater control to me for tighter placements.

figure('Name', 'Question 3 Combined', 'NumberTitle','off');
tile2 = tiledlayout('vertical');
tile2.TileSpacing = 'compact';
tile2.Padding = 'compact';

nexttile;
% The first signal.
plot((0 : 300)/sampling_frequency3b, x1_k3b(t3b),'r-', (0:30)/sampling_frequency3a,x1_k3a(t3a),'b+'); 
xlabel('n'); ylabel('y_1[n] and z_1[n]'); 
legend('z_1[n]','y_1[n]');

nexttile;
% The second signal
plot((0 : 300)/sampling_frequency3b,x2_k3b(t3b),'r-', (0:30)/sampling_frequency3a,x2_k3a(t3a),'b+');
xlabel('n'); ylabel('y_2[n] and z_2[n]'); 
legend('z_2[n]','y_2[n]');
