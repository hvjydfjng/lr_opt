function [fmin, xmin, count] = ave_point_centr(F, a, b, eps)
    h = 1e-6;  % шаг дл€ численного вычислени€ производной
    x_ = (a + b) / 2;
    
    % „исленное вычисление производной в точке x_
    dfx_ = numerical_derivative(F, x_, h);
    count = 2;
    while abs(dfx_) > eps
        if dfx_ > 0
            b = x_;
        else
            a = x_;
        end
        x_ = (a + b) / 2;
        
        % ќбновл€ем значение производной в новой точке
        dfx_ = numerical_derivative(F, x_, h);
        count = count + 2;
    end
    
    xmin = x_;
    fmin = F(xmin);
end

% ‘ункци€ дл€ численного вычислени€ производной (центральна€ разность)
function df = numerical_derivative(F, x, h)
    df = (F(x + h) - F(x - h)) / (2 * h);
end
