% Xóa bộ nhớ, xóa các biến trước đó
clc; clear all; format long;

% Định nghĩa miền thời gian và miền không gian
x_start = 0; x_end = 1;
L = x_end - x_start;
t_start = 0; t_end = 0.05;
T = t_end - t_start;

% Số phần tử không gian
Ne = 20;

% Spatial step size
dL = L / (Ne - 1);

% Khởi tạo lưới không gian
x = linspace(x_start, x_end, Ne);

% Điều kiện đầu
U_o = x.^2 + x;

% Điều kiện biên
UL = 0; UR = 2;

% Hệ số khuếch tán
D = 1;

% Hệ số đối lưu
V = 1;

% Định nghĩa lời giải chính xác
u_e = @(x, t) exp(-t) * (x.^2 - x) + 2 * x;

% Các giá trị Nt khác nhau
Nt_values = [5, 10, 15, 20, 30];
errors = zeros(length(Nt_values), 1);

% Duyệt qua các giá trị Nt
for idx = 1:length(Nt_values)
    Nt = Nt_values(idx);
    
    % Số bước thời gian
    dt = T / Nt;
    
    % Khởi tạo độ lỗi
    Er = 0;
    
    % Khởi tạo giá trị đầu
    U_o = x.^2 + x;
    
    % Vòng lặp thời gian
    for i_tim = 1:Nt
        MU = zeros(Ne); FU = zeros(Ne, 1);
        
        % Duyệt qua các phần tử không gian
        for k = 1:Ne
            % Tính toán source term
            S = -exp(-i_tim*dt) * (x(k)^2 - x(k) + 2);
            
            MU(k, k) = MU(k, k) + dL / dt;
            FU(k) = FU(k) + dL / dt * U_o(k) + S * dL;
            
            % Bên trong khối
            if k > 1 && k < Ne
                MU(k, [k k-1]) = MU(k, [k k-1]) + D / dL * [1 -1];
                MU(k, [k k+1]) = MU(k, [k k+1]) + D / dL * [1 -1];
            end
        end
        
        % Điều kiện biên trái
        %% Pha khuếch tán
        MU(1,1)     = MU(1,1) + D/dL*2;
        FU(1)       = FU(1) + D/dL*2*UL;
        MU(1,[1 2]) = MU(1,[1 2]) + D/dL*[1 -1];
        %% Pha đối lưu
        MU(1,[1 2]) = MU(1,[1 2]) + V/2*[1 1];
        FU(1)       = FU(1) + V*UL;


        % Điều kiện biên phải
        %% Pha khuếch tán
        MU(Ne,[Ne Ne-1]) = MU(Ne,[Ne Ne-1]) + D/dL*[1 -1];
        MU(Ne,Ne)        = MU(Ne,Ne) + D/dL*2;
        FU(Ne)           = FU(Ne) + D/dL*2*UR;
        %% Pha đối lưu
        MU(Ne,[Ne Ne-1]) = MU(Ne,[Ne Ne-1]) - V/2*[1 1];
        FU(Ne)           = FU(Ne) - V*UR;
        
        % Giải hệ phương trình tuyến tính
        U = MU \ FU; U_o = U;
        
        % Tính toán độ lỗi
        U_exact = u_e(x, i_tim * dt);
        Ert = sum((U - U_exact').^2) * dL;
        Er = Er + dt * Ert;
    end
    
     % Lưu trữ giá trị độ lỗi ứng với giá trị Nt
    errors(idx) = sqrt(Er);
end

% Trực quan hóa độ lỗi
figure;
plot(Nt_values, errors, 'o-');
title('Error between u_h and u_e for different Nt values');
xlabel('Number of Time Steps (Nt)');
ylabel('RMS Error');
grid on;