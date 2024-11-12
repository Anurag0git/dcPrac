% Parameter
N = 1000;
t = 1:N;

% Generate random process
x = randn(1, N);
mean_x = mean(x);
var_x = var(x);
autocorr_x = xcorr(x, 'biased');

% Compute Power Spectral Density using FFT
X = fft(x);
psd_fft = (1/(N * 2 * pi)) * abs(X).^2; % Normalize
psd_fft = psd_fft(1:N/2+1); % Take only the first half (positive frequencies)
freq = (0:N/2) / N; % Frequency vector

% Plotting
figure;

% Plot the random process
subplot(2, 2, 1);
plot(t, x);
title('Random Process');
xlabel('Time index');
ylabel('Amplitude');

% Plot the autocorrelation function
lag = -(N-1):(N-1);
subplot(2, 2, 2);
plot(lag, autocorr_x);
title('Autocorrelation');
xlabel('Lag');
ylabel('Autocorrelation');

% Plot the Power Spectral Density
subplot(2, 2, 3);
plot(freq, psd_fft);
title('Power Spectral Density');
xlabel('Frequency');
ylabel('Power');

% Display statistical parameters
disp('Statistical Parameters');
disp(['Mean: ', num2str(mean_x)]);
disp(['Variance: ', num2str(var_x)]);
