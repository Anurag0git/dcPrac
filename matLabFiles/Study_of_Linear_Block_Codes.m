% Simulation Study of Block Codes
clc;
clear;
close all;
n = input('Enter the number of code bits:');
k = input('Enter the number of message bits:');
P = input('Enter the parity matrix:');
m = input('Enter the message bits:');
G = [eye(k), P];
X = encode(m, n, k, 'linear', G);
disp('Codeword X is:');
disp(X);
D = decode(X, n, k, 'linear', G);
disp('Decoded message is:');
disp(D);