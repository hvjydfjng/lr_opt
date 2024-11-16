function [fmin, xmin,count] = hords_left(F, a, b, eps)
    h = 1e-6;  % шаг дл€ численного вычислени€ производной
    x_ = a - numerical_derivative(F, a, h) / (numerical_derivative(F, a, h) - numerical_derivative(F, b, h)) * (a - b); % ѕо формуле вычисл€ем как точку минимума
    dfx_ = numerical_derivative(F, x_, h);
    count = 6;
    while abs(dfx_) > eps
        if dfx_ > 0
            b = x_;
        else
            a = x_;
        end
        x_ = a - numerical_derivative(F, a, h) / (numerical_derivative(F, a, h) - numerical_derivative(F, b, h)) * (a - b);
        dfx_ = numerical_derivative(F, x_, h);
        count = count + 6;
    end
    xmin = x_;
    fmin = F(xmin);
end    

% ‘ункци€ дл€ численного вычислени€ производной (лева€ разность)
function df = numerical_derivative(F, x, h)
    df = (F(x) - F(x - h)) / h;
end
