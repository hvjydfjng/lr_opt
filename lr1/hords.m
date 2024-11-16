function [fmin, xmin,count] = hords(F, a, b, eps)
    df = dy(F);
    x_ = a - y(df,a)/(y(df,a) - y(df,b))*(a-b); % ѕо формуле вычисл€ем как точку мимнимума
    dfx_ = y(df, x_);
    count = 3;
    while abs(dfx_) > eps
        if dfx_ > 0
            b = x_;
        else
            a = x_;
        end
        x_ = a - y(df,a)/(y(df,a) - y(df,b))*(a-b);
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
