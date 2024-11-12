% Simulation Study of Performance of M-ary PSK
clc;
clear;
close all;

% M-ary PSK parameters
M = 4; % M-PSK (e.g., QPSK)
k = log2(M); % Number of bits per symbol
Ebno_DB = 0:10; % Range of Eb/No values in dB
num_bits = 1000; % Total number of bits to transmit
num_symbols = num_bits / k; % Number of symbols

% Initialize BER array
BER = zeros(1, length(Ebno_DB));

% Define PSK constellation
psk_constellation = exp(1j * (2 * pi * (0:M-1) / M)); % M-PSK constellation points

% Loop over each Eb/No value
for i = 1:length(Ebno_DB)
    % Generate random bits and group into symbols manually
    bits = randi([0, 1], 1, num_bits);
    reshaped_bits = reshape(bits, k, []).'; % Reshape bits into k-bit groups (2 for QPSK)
    symbols = reshaped_bits * (2.^(k-1:-1:0)).'; % Convert each k-bit group to decimal value

    % M-PSK modulation (map symbols to constellation points)
    tx_symbols = psk_constellation(symbols + 1); % Map symbols to PSK constellation

    % Add AWGN based on Eb/No
    snr = Ebno_DB(i) + 10*log10(k); % Calculate SNR from Eb/No
    rx_symbols = awgn(tx_symbols, snr, 'measured'); % Add AWGN

    % M-PSK demodulation (Euclidean distance to nearest constellation point)
    rx_symbols_demod = zeros(1, num_symbols);
    for j = 1:num_symbols
        [~, rx_symbols_demod(j)] = min(abs(rx_symbols(j) - psk_constellation));
    end
    rx_symbols_demod = rx_symbols_demod - 1; % Adjust indices to match symbol values

    % Convert demodulated symbols back to bits
    rx_bits = de2bi(rx_symbols_demod, k).'; % Convert symbols back to bits
    rx_bits = rx_bits(:).'; % Reshape to a 1-D bit stream

    % Calculate BER
    errors = sum(bits ~= rx_bits);
    BER(i) = errors / num_bits;
end

% Plot BER vs. Eb/No
figure;
semilogy(Ebno_DB, BER, '-o');
xlabel("Eb/No (dB)");
ylabel("Bit Error Rate (BER)");
title("Performance of M-ary PSK");
grid on;
