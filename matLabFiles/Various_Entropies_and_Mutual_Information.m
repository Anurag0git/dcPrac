clc;
clear ;

% Input
i = input('Enter number of elements: ');
q = input('Enter joint probability matrix: ');

% Check if the sum of the joint probability matrix is 1
if abs(sum(q(:)) - 1) > 1e-6
    error('The sum of all joint probabilities must be 1.');
end

% Probability P(x)
p = sum(q, 2); % Sum along rows to get marginal probabilities for X
disp('P(x):');
disp(p);

% Entropy H(x)
H = -sum(p .* log2(p));
disp('H(x):');
disp(H);

% Conditional probability matrix P(Y|X)
a = q ./ p;
disp('P(Y|X):');
disp(a);

% Entropy H(Y|X)
H1 = -sum(q(q > 0) .* log2(a(q > 0)));
disp('H(Y|X):');
disp(H1);

% Mutual Information (MI)
MI = H - H1;
disp('MI:');
disp(MI);

% Probability P(Y)
s = sum(q, 1); % Sum along columns to get marginal probabilities for Y
disp('P(Y):');
disp(s);

% Entropy H(Y)
H2 = -sum(s .* log2(s));
disp('H(Y):');
disp(H2);
