% Bai tap 1.8

% Tinh cac tinh phan sau

syms x  y alpha phi r;

% a)
%% Define function
f = x * sqrt(x^2 - 1);

%% Calculating the integral
F = int(f, x);

%% Display
disp(F);

% b) 
%% Define function
f = 1 / (1 + x^2);

%% Calculating the integral
F = int(f, x);

%% Display
disp(F);

% c)
%% Define function
f = x^2 * sqrt(alpha^2 - x^2);

%% Calculating the integral
F = int(f, x, 0, alpha);

%% Display
disp(F);

% d)
%% Define function
f = 1 / sqrt(alpha^2 + x^2);

%% Calculating the integral
F = int(f, x, -alpha, alpha);

%% Display
disp(F);

% e)
%% Define function
f = exp(x) * sin(y);

%% Calculating the integral
F = int(int(f, x), y);

%% Display
disp(F);

% f)
%% Define function
f = 1 / sqrt(y^2 - x^2);

%% Calculating the integral
F = int(int(f, x), y);

%% Display
disp(F);


% g)
%% Define function
f = cos(phi) * r^2;

%% Calculating the integral
F = int(int(f, phi, 0, pi/ 2), r, alpha / 2, alpha);

%% Display
disp(F);

% h) 
%% Define function
f = 1 / (4 - x^2);

%% Calculating the integral
F = int(int(f, x, -1, y), y, -1, 1);

%% Display
disp(F);


