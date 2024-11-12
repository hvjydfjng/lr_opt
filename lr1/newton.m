function [fmin, xmin, count] = newton(F, a, b, x0, eps)
    df = dy(F)
    ddf = dy(df);
    count = 0;
    x_ = x0 - y(df,x0)/y(ddf,x0); % ѕо формуле вычисл€ем как точку мимнимума
    dfx_ = y(df, x_);
    count = count +3;
    while abs(dfx_) > eps
         x_ = x_ - y(df,x_)/y(ddf,x_);
         dfx_ = y(df, x_);
         count = count + 3;
    end
    xmin = x_;
    fmin = y(F, xmin);
end    

function fx = y(F, xi)
    fx = double(subs(F, xi));
end

function df = dy(F)
    syms x
    df = diff(F,x);
end
