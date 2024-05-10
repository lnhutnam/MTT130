% Bai tap 1.9
syms x y z;

% a) 
%% Define the equation
f = x^4 - 7*x^3 + 3*x^2 - 5*x + 9;

%% Solve the equation
solutions = vpasolve(f, x);

%% Display the solutions
disp(solutions);


% b) 
%% Define the equation
f = exp(x) - x^2 - 1;

%% Solve the equation
solutions = vpasolve(f, x);

%% Display the solutions
disp(solutions);

% c)
%% Define the equations
f1 = sin(4*x) - cos(2*x);
f2 = x - 3*y;

%% Solve the system of equations
solutions = vpasolve([f1 == 0, f2 == 0], [x, y]);

%% Display the solutions
disp(solutions);

% d)
%% Define the equations
f1 = x + 3*y - 2*z - 5;
f2 = 3*x + 3*y - 2*z - 7;
f3 = 2*x + 4*y + 3*z - 8;

%% Solve the system of equations
solutions = vpasolve([f1 == 0, f2 == 0,f3 == 0], [x, y, z]);

%% Display the solutions
disp(solutions);
