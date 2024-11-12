function [fmin, xmin, count] = ave_point_left(F, a, b, eps)
    h = 1e-6;  % шаг для численного вычисления производной
    x_ = (a + b) / 2;
    
    % Численное вычисление производной в точке x_ с использованием левой разности
    dfx_ = numerical_derivative(F, x_, h);
    count = 2;
    while abs(dfx_) > eps
        if dfx_ > 0
            b = x_;
        else
            a = x_;
        end
        x_ = (a + b) / 2;
        
        % Обновляем значение производной в новой точке
        dfx_ = numerical_derivative(F, x_, h);
        count = count + 2;
    end
    
    xmin = x_;
    fmin = F(xmin);
end

% Функция для численного вычисления производной (левая разность)
function df = numerical_derivative(F, x, h)
    df = (F(x) - F(x - h)) / h;
end
