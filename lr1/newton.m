function [fmin, xmin, count] = newton(F, a, b, x0, eps)
    df = dy(F);
    ddf = dy(df);
    count = 0;
    x_ = x0 - y(df,x0)/y(ddf,x0); % По формуле вычисляем как точку мимнимума
    dfx_ = y(df, x_);
    count = count +3;
    while abs(dfx_) > eps
         x_ = x_ - y(df,x_)/y(ddf,x_);
         dfx_ = y(df, x_);
         count = count + 3;
         if count > 1000
            disp('Метод Ньютона не сходится, попробуйте другое начальное приближение')
             break;
         end
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
