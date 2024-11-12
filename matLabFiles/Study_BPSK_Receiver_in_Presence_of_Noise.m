% Transmitter part
clc;
clear;
close all;
nr_data_bits = 8192;
b_data = (randn(1, nr_data_bits)) > 0.5;
b = [b_data];
d = zeros(1, length(b));
for n = 1:length(b)
    if(b(n) == 0)
        d(n) = exp(1j*2*pi);
    else
        d(n) = exp(1j*pi);
    end
end
bpsk = d;
figure(1);
plot(real(d), imag(d), 'o');
axis([-2, 2, -2, 2]);
grid on;
xlabel("Real");
ylabel("Imag");
title("BPSK Constellation");
SNR_vals = 0:24;
BER1 = [];
SNR1 = [];
for SNR = SNR_vals
    sigma = sqrt(10.0^(-SNR / 10.0));
    snbpsk = (real(bpsk) + sigma * randn(size(bpsk))) + 1i * (imag(bpsk) + sigma * randn(size(bpsk)));
    % Plotting with noise
    figure(2);
    plot(real(snbpsk), imag(snbpsk), 'o');
    axis([-2, 2, -2, 2]);
    grid on;
    xlabel("Real");
    ylabel("Imag");
    title(["BPSK Constellation with Noise, SNR =", num2str(SNR)]);
    pause(0.5); % Pause to view each plot for each SNR level
    % Receiver error
    bhat = real(snbpsk) < 0;
    ne = sum(b ~= bhat);
    BER = ne / nr_data_bits;
    BER1 = [BER1, BER];
    SNR1 = [SNR1, SNR];
end