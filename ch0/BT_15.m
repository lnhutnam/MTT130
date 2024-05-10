% Bai tap 1.5
% Kiem tra su lien tuc cua cac ham so sau

% a)
syms x;

%% Define the function
f = (1 + abs(x))^{1/x};

%% Calculate the limit of the function as x approaches 0
limit_f = limit(f, x, 0, 'right');
limit_f_left = limit(f, x, 0, 'left');

%% Check if the limit from both sides is the same
if limit_f == limit_f_left
    fprintf('The function f = (1 + abs(x))^{1/x} is continuous at x = 0.\n');
else
    fprintf('The function f = (1 + abs(x))^{1/x} is not continuous at x = 0.\n');
end


% b)
%% Define the function
f = 1 / (x - 1)^2;

%% Calculate the limit of the function as x approaches 1
limit_f = limit(f, x, 1, 'right');
limit_f_left = limit(f, x, 1, 'left');

%% Check if the limit from both sides is the same
if limit_f == limit_f_left
    fprintf('The function f = 1 / (x - 1)^2 is continuous at x = 1.\n');
else
    fprintf('The function f = 1 / (x - 1)^2 is not continuous at x = 1.\n');
end

% c)
%% Define the function
f = sin(x) / abs(x);

%% Calculate the limit of the function as x approaches 0
limit_f = limit(f, x, 0, 'right');
limit_f_left = limit(f, x, 0, 'left');

%% Check if the limit from both sides is the same
if limit_f == limit_f_left
    fprintf('The function f = sin(x) / abs(x) is continuous at x = 0.\n');
else
    fprintf('The function f = sin(x) / abs(x) is not continuous at x = 0.\n');
end

% d)
%% Define the function
f = 1 / (1 + exp(1/x));

%% Calculate the limit of the function as x approaches 0
limit_f = limit(f, x, 0, 'right');
limit_f_left = limit(f, x, 0, 'left');

%% Check if the limit from both sides is the same
if limit_f == limit_f_left
    fprintf('The function f = 1 / (1 + exp(1/x)); is continuous at x = 0.\n');
else
    fprintf('The function f = 1 / (1 + exp(1/x)); is not continuous at x = 0.\n');
end



