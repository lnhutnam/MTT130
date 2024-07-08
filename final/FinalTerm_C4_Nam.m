% Xét bài toán khuếch tán như sau
% \dfrac{\partial u}{\partial t}(x, t) = D \dfrac{\partial^2 u}{\partial^2 x}(x, t) 
% - V \dfrac{\partial u}{\partial x}(x, t),

% Với $D = 1$ và $V = 1$, hãy giải bài toán (\ref{eq:problem4}) tìm nghiệm 
% xấp xỉ $u_h$ tại thời điểm $t = 5$ với lưới 20 phần tử và 10 bước thời gian.

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

% Hệ số đối lưu
V = 1;

% Điều kiện đầu
U_o = (ele.coo).^2 + ele.coo;

% Các điều kiện biên
UL = 0; UR = 2;

% Khởi tạo giá trị độ lỗi
Er = 0;

% Cài đặt bộ giải
for i_tim=1:Nt              % Vòng lặp thời gian
    MU = zeros(Ne); FU = zeros(Ne,1);
    for k=1:Ne              % Vòng lặp thể tích
        % Tính toán source term
        S = -exp(-i_tim*dt) * (ele.coo(k)^2 - ele.coo(k) + 2);

        MU(k,k) = MU(k,k) + dL/dt;
        FU(k) = FU(k) + dL/dt*U_o(k) + S*dL;

        % inside volume
        if k > 1 && k < Ne      
            % Tính toán pha khuếch tán
            MU(k,[k k-1]) = MU(k,[k k-1]) + D/dL*[1 -1];
            MU(k,[k k+1]) = MU(k,[k k+1]) + D/dL*[1 -1];

            % Tính toán pha đối lưu
            MU(k,[k k-1]) = MU(k,[k k-1]) - V/2*[1 1];
            MU(k,[k k+1]) = MU(k,[k k+1]) + V/2*[1 1];
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
    U = MU\FU; U_o = U; 
    X = [0 ele.coo 1]; UU = [UL; U; UR];
    plot(X',UU,'b-'); pause(0.5);

    % Tính toán độ lỗi
    Ert=0; Ue=zeros(Ne,1);
    for k=1:Ne
        Ue(k) = exp(-i_tim*dt)*(ele.coo(k)^2 - ele.coo(k)) + 2 * ele.coo(k);
        Ert = Ert + (U(k) - Ue(k))^2*dL;
    end
    Er = Er + dt*Ert;
end % loop of time

Er=sqrt(Er); disp(Er);