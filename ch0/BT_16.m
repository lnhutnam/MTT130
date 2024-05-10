% Bai tap 1.6

syms x;

fx = exp(x) * sin(x);
gx = exp(x) * cos(x);

% a) Chung minh rang f'(x) + g'(x) = 2g(x)
fprintf("a) Chung minh rang f'(x) + g'(x) = 2g(x).\n");
df_fx = diff(fx, x);
df_gx = diff(gx, x);

if simplify(df_fx + df_gx) == 2*gx
    fprintf("Proved: f'(x) + g'(x) = 2g(x).\n");
else
    fprintf("Proved: f'(x) + g'(x) != 2g(x).\n");
end

% b) Chung minh rang f''(x) + g''(x) = 2(g(x) - f(x))
fprintf("b) Chung minh rang f''(x) + g''(x) = 2(g(x) - f(x).\n");
df2_fx = diff(df_fx, x);
df2_gx = diff(df_gx, x);

if simplify(df2_fx + df2_gx) == 2*(gx - fx)
    fprintf("Proved: f''(x) + g''(x) = 2(g(x) - f(x).\n");
else
    fprintf("Proved: f''(x) + g''(x) != 2(g(x) - f(x).\n");
end

% c) Chung minh rang f'''(x) + g'''(x) =  - 4f(x)
fprintf("b) Chung minh rang f'''(x) + g'''(x) =  - 4f(x).\n");
df3_fx = diff(df2_fx, x);
df3_gx = diff(df2_gx, x);

if simplify(df3_fx + df3_gx) == -4*fx
    fprintf("Proved: f'''(x) + g'''(x) =  - 4f(x).\n");
else
    fprintf("Proved: f'''(x) + g'''(x) !=  - 4f(x).\n");
end


