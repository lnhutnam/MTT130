% Bai tap 1.6

syms x  y;


% Define a function
f = exp(x+y) * (x - y);

% a) Chung minh rang
df2_dxdy = diff(diff(f, x), y);
df2_dydx = diff(diff(f, y), x);

if df2_dxdy == df2_dydx
    fprintf("Proved: df2_dxdy = df2_dydx.\n")
end

% b) 
df_dx = diff(f, x);
df_dy = diff(f, y);

df2_dxdx = diff(diff(f, x), x);
df2_dydy = diff(diff(f, y), y);

if simplify(df_dx + df_dy) ==  simplify(df2_dxdx + df2_dydy)
    fprintf("Proved: df_dx + df_dy = df2_dxdx + df2_dydy.\n")
end

% c)
df3_dxdxdy = diff(df2_dxdx, y);
df3_dydydx = diff(df2_dydy, x);

df3_dxdxdx = diff(df2_dxdx, x);
df3_dydydy = diff(df2_dydy, y);

if simplify(df3_dxdxdy + df3_dydydx) ==  simplify(df3_dxdxdx + df3_dydydy)
    fprintf("Proved: df3_dxdxdy + df3_dydydx = df3_dxdxdx + df3_dydydy.\n")
end

