clc;
clear;
% Input
x = input('Enter number of symbols: ');
symbols = zeros(1, x);
p = zeros(1, x);
for m = 1:x
    symbols(m) = input(['Enter symbol number ', num2str(m), ': ']);
    p(m) = input(['Enter the probability for symbol ', num2str(symbols(m)), ':']);
end
% Calculate entropy
Hx = 0;
for m = 1:x
    Hx = Hx + p(m) * (-log2(p(m)));
end
% Huffman dictionary and average length
[dict, avglen] = huffmandict(symbols, p);
% Display results
disp('Entropy:');
disp(Hx);
% Efficiency calculation
Efficiency = (Hx / avglen) * 100;
disp('Efficiency:');
disp(Efficiency);