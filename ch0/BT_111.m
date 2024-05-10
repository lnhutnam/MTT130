% Bai tap 1.11

% Define the range of x values
x = linspace(-5, 5, 1000);

% a)
% Define the functions
f1 = abs(x.^2 + 3*x);
f2 = x.^3 - x - 2;

% Create a figure with two subplots side by side
figure;

% Plot f1 in the first subplot
subplot(1, 2, 1);
plot(x, f1, 'r', 'LineWidth', 2); % Plot f1 in red
xlabel('x');
ylabel('f_1(x)');
title('Plot of |x^2 + 3x|');

% Plot f2 in the second subplot
subplot(1, 2, 2);
plot(x, f2, 'b', 'LineWidth', 2); % Plot f2 in blue
xlabel('x');
ylabel('f_2(x)');
title('Plot of x^3 - x - 2');

% b)
% Define the range of x values
x = linspace(0, 5, 100);

% Define the functions
f1 = x.^2;
f2 = sqrt(x);

% Create a figure with two subplots stacked vertically
figure;

% Plot f1 (x^2) in the upper subplot
subplot(2, 1, 1);
plot(x, f1, 'r', 'LineWidth', 2); % Plot f1 in red
xlabel('x');
ylabel('f_1(x)');
title('Plot of x^2');

% Plot f2 (sqrt(x)) in the lower subplot
subplot(2, 1, 2);
plot(x, f2, 'b', 'LineWidth', 2); % Plot f2 in blue
xlabel('x');
ylabel('f_2(x)');
title('Plot of sqrt(x)');

% c)
% Define the range of x values
x = linspace(-5, 5, 1000);

% Define functions
f1 = exp(x);
f2 = log(x);
f3 = sin(x);
f4 = cos(x);

% Create a figure with two subplots side by side
figure;

% Plot f1 in the first subplot
subplot(2, 2, 1);
plot(x, f1, 'r', 'LineWidth', 2); % Plot f1 in red
xlabel('x');
ylabel('f_1(x)');
title('Plot of exp(x)');

% Plot f2 in the second subplot
subplot(2, 2, 2);
plot(x, f2, 'b', 'LineWidth', 2); % Plot f2 in blue
xlabel('x');
ylabel('f_2(x)');
title('Plot of log(x)');

% Plot f3 in the second subplot
subplot(2, 2, 3);
plot(x, f3, 'g', 'LineWidth', 2); % Plot f2 in blue
xlabel('x');
ylabel('f_2(x)');
title('Plot of sin(x)');

% Plot f3 in the second subplot
subplot(2, 2, 4);
plot(x, f4, 'y', 'LineWidth', 2); % Plot f2 in blue
xlabel('x');
ylabel('f_2(x)');
title('Plot of cos(x)');

