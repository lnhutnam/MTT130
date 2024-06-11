% Nam Le

clc; clear; format long % set up

L = 1; Ne = 20;
T = 1; Nt = 20;

UL = 0; UR = 1;

[err, U, ele_coo] = One1DProblemSourceTerm(L, Ne, T, Nt, UL, UR);

hold on
X = [0 ele_coo 1]; 
UU = [UL; U; UR];
plot(X', UU, 'b-');
syms x
f = exp(-1) * sin(pi * x) + x;
fplot(f, [0 1]);
title('t=1')
legend('approximate solution', 'exact solution');

% Phuong trinh:
% \partial u / \partial t = D \partial^2 u / \partial x^2 + S(x, t)
% trong do:
% S(x, t) = 0.02 if 0.4 < x < 0.5 else 0 for otherwise

function [err, U, ele_coo] = One1DProblemSourceTerm(L, Ne, T, Nt, UL, UR)
    dL = L / Ne;
    ele_coo = (dL/2):dL:L;
    
    dt = T / Nt;

    D = 1 / pi^2; Er = 0;
    U_o = sin(pi * ele_coo) + ele_coo;

    for i_tim = 1:Nt  % loop of time
        MU = zeros(Ne); FU = zeros(Ne, 1);
        for k = 1:Ne  % loop of volume

            MU(k, k) = MU(k, k) + dL / dt;
            FU(k) = FU(k) + dL / dt * U_o(k);

            % Add source term S(x, t)
            x_k = ele_coo(k);
            if x_k > 0.4 && x_k < 0.5
                S = 0.02;
            else
                S = 0;
            end
            FU(k) = FU(k) + S * dL;


            if k > 1 && k < Ne  % inside volume
                MU(k, [k k-1]) = MU(k, [k k-1]) + D / dL * [1 -1];
                MU(k, [k k+1]) = MU(k, [k k+1]) + D / dL * [1 -1];
            end

        end

        % left boundary
        MU(1, 1) = MU(1, 1) + D / dL * 2;
        FU(1) = FU(1) + D / dL * 2 * UL;
        MU(1, [1 2]) = MU(1, [1 2]) + D / dL * [1 -1];

        % right boundary        
        MU(Ne, [Ne Ne-1]) = MU(Ne, [Ne Ne-1]) + D / dL * [1 -1];
        MU(Ne, Ne) = MU(Ne, Ne) + D / dL * 2;
        FU(Ne) = FU(Ne) + D / dL * 2 * UR;

        % solve system of linear equation
        U = MU \ FU; 
        U_o = U;

        % compute error
        Ert = 0; 
        Ue = zeros(Ne, 1);
        for k = 1:Ne
            Ue(k) = exp(-i_tim * dt) * sin(pi * ele_coo(k)) + ele_coo(k);
            Ert = Ert + (U(k) - Ue(k))^2 * dL;
        end
        Er = Er + dt * Ert;
    end % loop of time
    err = sqrt(Er); 
    disp(err);
end