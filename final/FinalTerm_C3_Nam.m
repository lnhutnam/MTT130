% Cho bài toán khuếch tán như sau:
% \dfrac{\partial u}{\partial t}(x, t) = D\dfrac{\partial^2 u}{\partial^2 x}(x, t) + S(x, t)

% Câu 3: Cho $D = 1$ và lưới 20 phần tử, 10 bước thời gian. Cho 
%\begin{equation}
%    S = \begin{cases}
%        30,\quad x \in K\\
%        0,\quad x \notin k
%    \end{cases}
%\end{equation}
% Hãy xác định ví trí của phần tử $K$ sao cho tổng nhiệt lượng tại $t = 5$ 
% đạt giá trị lớn nhất. Nhận xét về vấn đề này.

% Giải quyết bài toán
% Xóa bộ nhớ, xóa các biến trước đó
clc; clear all; format long % set up

% Khoảng giá trị của x
x_start = 0; x_end = 1;

% Chiều dài không gian
L = x_end - x_start;

% Khoảng giá trị của t
t_start = 0; t_end = 5;

% Tổng thời gian
T = t_end - t_start;

% Số lượng phần tử của lưới
Ne = 20;

% Kích thước bước không gian (Spatial step size)
dL = L / Ne;

% Khởi tạo các phần tử
ele.coo = (dL / 2):dL:L;

% Số lượng bước thời gian
Nt = 10;

% Kích thước bước thời gian (Time step size)
dt = T / Nt;

% Hệ số khuếch tán
D = 1;

% Điều kiện đầu
U_o = (ele.coo).^2 + ele.coo;

% Các điều kiện biên
UL = 0; UR = 2;

% Khởi tạo giá trị độ lỗi
Er = 0;

% Cài đặt bộ giải
% Xác định phần tử K tối ưu
max_total_heat = -Inf;
optimal_K_start = 0;
optimal_K_end = 0;

for K_start = 1:50
    for K_end = K_start:50
        % Khởi tạo lại điều kiện đầu 
        ele.coo = 0;
        ele.coo = (dL / 2):dL:L;

        % Điều kiện đầu
        U_o = (ele.coo).^2 + ele.coo;

        % Các điều kiện biên
        UL = 0; UR = 2;

        total_heat = compute_total_heat(K_start, K_end, Nt, Ne, ele, dL, dt, U_o, D, UL, UR);

        % Check if this is the maximum total heat
        if total_heat > max_total_heat
            max_total_heat = total_heat;
            optimal_K_start = K_start;
            optimal_K_end = K_end;
        end
    end
end

% Display results
fprintf('Optimal K is from x = %.2f to x = %.2f\n', (optimal_K_start-1)*dL, (optimal_K_end-1)*dL);
fprintf('Maximum total heat at t = 5 is %.2f\n', max_total_heat);

function total_heat = compute_total_heat(K_start, K_end, Nt, Ne, ele, dL, dt, U_o, D, UL, UR)
    Er = 0;
    S = zeros(Ne, 1);
    S(K_start:K_end) = 30;

    for i_tim=1:Nt              % Vòng lặp thời gian
        MU = zeros(Ne); FU = zeros(Ne,1);
        for k=1:Ne              % Vòng lặp thể tích

            MU(k,k) = MU(k,k) + dL/dt;
            FU(k) = FU(k) + dL/dt*U_o(k) + S(k)*dL;
    
            % inside volume
            if k > 1 && k < Ne      
                MU(k,[k k-1]) = MU(k,[k k-1]) + D/dL*[1 -1];
                MU(k,[k k+1]) = MU(k,[k k+1]) + D/dL*[1 -1];
            end
        end
    
        % Điều kiện biên trái
        MU(1,1)     = MU(1,1) + D/dL*2;
        FU(1)       = FU(1) + D/dL*2*UL;
        MU(1,[1 2]) = MU(1,[1 2]) + D/dL*[1 -1];
    
        % Điều kiện biên phải
        MU(Ne,[Ne Ne-1]) = MU(Ne,[Ne Ne-1]) + D/dL*[1 -1];
        MU(Ne,Ne)        = MU(Ne,Ne) + D/dL*2;
        FU(Ne)           = FU(Ne) + D/dL*2*UR;
    
        % Giải hệ phương trình tuyến tính
        U = MU\FU; U_o = U; 
        X = [0 ele.coo 1]; UU = [UL; U; UR];
    
        % Tính toán độ lỗi
        Ert=0; Ue=zeros(Ne,1);
        for k=1:Ne
            Ue(k) = exp(-i_tim*dt)*(ele.coo(k)^2 - ele.coo(k)) + 2 * ele.coo(k);
            Ert = Ert + (U(k) - Ue(k))^2*dL;
        end
        Er = Er + dt*Ert;
    end % loop of time

    % Total heat at t = 5
    total_heat = sum(U(:, end)) * dL;
    fprintf("Total head: %.2f\n", total_heat);
    fprintf("Error: %.2f\n", Er);
end

