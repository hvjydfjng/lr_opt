function [fmin, xmin, count] = newton_centr(F, a, b, x0, eps)
    h = 1e-6;  % шаг для численного вычисления производной
    count = 0;

    % Численное вычисление первой и второй производных в начальной точке
    df = numerical_derivative(F, x0, h);
    ddf = numerical_second_derivative(F, x0, h);

    % По формуле вычисляем первую точку минимума
    x_ = x0 - df / ddf;
    dfx_ = numerical_derivative(F, x_, h);
    count = count + 7; % Учитываем три вызова функции на начальной итерации

    while abs(dfx_) > eps
        % Пересчитываем первую и вторую производные
        df = numerical_derivative(F, x_, h);
        ddf = numerical_second_derivative(F, x_, h);
        
        % Обновляем точку минимума
        x_ = x_ - df / ddf;

        % Пересчитываем производную в новой точке
        dfx_ = numerical_derivative(F, x_, h);
        count = count + 7; % Каждая итерация требует 3 вызовов функции
        if count > 3000
            disp('Метод Ньютона не сходится, попробуйте другое начальное приближение')
             break;
         end
    end

    xmin = x_;
    fmin = F(xmin);
end

% Численное вычисление первой производной (центральная разность)
function df = numerical_derivative(F, x, h)
    df = (F(x + h) - F(x - h)) / (2 * h);
end

% Численное вычисление второй производной (центральная разность)
function ddf = numerical_second_derivative(F, x, h)
    ddf = (F(x + h) - 2 * F(x) + F(x - h)) / (h^2);
end
