% Xóa bộ nhớ, xóa các biến trước đó
clc; clear all; format long;

% Định nghĩa miền thời gian và miền không gian
x_start = 0; x_end = 1;
L = x_end - x_start;
t_start = 0; t_end = 0.05; % Định nghĩa thời gian cuối cùng để phân tích
T = t_end - t_start;

% Số lượng phần tử không gian
Ne = 20; % Đây là một hằng số

% Kích thước bước nhảy
dL = L / (Ne - 1);

% Khởi tạo lưới không gian
x = linspace(x_start, x_end, Ne);

% Điều kiện đầu
U_o = x.^2 + x;

% Điều kiện biên
UL = 0; UR = 2;

% Lời giải cho nghiệm chính xác
u_e = @(x, t) exp(-t) * (x.^2 - x) + 2 * x;

% Khảo sát các giá trị hệ số khuếch tán D khác nhau
D_values = [0, 1, 2, 3, 4, 5];
errors = zeros(length(D_values), 1);
u_h_values = zeros(length(D_values), Ne);

% Số lượng bước thời gian
Nt = 10; % Đây là một hằng số

% Kích thước bước thời gian
dt = T / Nt;

% Duyệt qua từng giá trị D
for idx = 1:length(D_values)
    D = D_values(idx);
    
    % Khởi tạo giá trị độ lỗi bằng 0
    Er = 0;
    
    % Khởi tạo giá trị đầu ứng với giá trị D
    U_o = x.^2 + x;
    
    % Vòng lặp thời gian
    for i_tim = 1:Nt
        MU = zeros(Ne); FU = zeros(Ne, 1);
        
        % Duyệt qua phần tử không gian
        for k = 1:Ne
            % S = -exp(-i_tim*dt) * (x(k)^2 - x(k) + 2); % Source term
            S = 0;
            
            MU(k, k) = MU(k, k) + dL / dt;
            FU(k) = FU(k) + dL / dt * U_o(k) + S * dL;
            
            % Bên trong khối
            if k > 1 && k < Ne
                MU(k, [k k-1]) = MU(k, [k k-1]) + D / dL * [1 -1];
                MU(k, [k k+1]) = MU(k, [k k+1]) + D / dL * [1 -1];
            end
        end
        
        % Điều kiện biên trái
        MU(1, 1) = MU(1, 1) + D / dL * 2;
        FU(1) = FU(1) + D / dL * 2 * UL;
        MU(1, [1 2]) = MU(1, [1 2]) + D / dL * [1 -1];
        
        % Điều kiện biên phải
        MU(Ne, [Ne Ne-1]) = MU(Ne, [Ne Ne-1]) + D / dL * [1 -1];
        MU(Ne, Ne) = MU(Ne, Ne) + D / dL * 2;
        FU(Ne) = FU(Ne) + D / dL * 2 * UR;
        
        % Giải hệ phương trình tuyến tính
        U = MU \ FU; U_o = U;
        
        % Tính toán độ lỗi tại bước thời gian
        U_exact = u_e(x, i_tim * dt);
        Ert = sum((U - U_exact').^2) * dL;
        Er = Er + dt * Ert;
    end
    
    % Lưu trữ độ lỗi và kết quả lời giải số học u_h tại thời điểm t = 0.05
    errors(idx) = sqrt(Er);
    u_h_values(idx, :) = U';
end

% Trực quan hóa sự thay đổi u_h tại thời điểm t = 0.05 ứng với các giá trị
% D khác nhau
figure;
hold on;
for idx = 1:length(D_values)
    plot(x, u_h_values(idx, :), 'DisplayName', ['D = ' num2str(D_values(idx))]);
end
title('Change of u_h at t = 0.05 for different D values');
xlabel('x');
ylabel('u_h');
legend show;
grid on;
hold off;

% Trực quan hóa độ lỗi với từng giá trị D khác nhau
figure;
plot(D_values, errors, 'o-');
title('Error between u_h and u_e for different D values');
xlabel('Diffusion Coefficient (D)');
ylabel('RMS Error');
grid on;