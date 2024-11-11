function [fmin, xmin] = gold(F, a, b, eps)
    t = (sqrt(5) - 1) / 2;
    n = 1;
    
    % Начальные значения
    [x1, x2] = x_solve(a, b);
    f1 = y(F, x1);
    f2 = y(F, x2);
    
    while (b - a) / 2 > eps
        if f1 <= f2
            b = x2;
            x2 = x1;
            f2 = f1;
            x1 = b - t * (b - a);
            f1 = y(F, x1);
        else
            a = x1;
            x1 = x2;
            f1 = f2;
            x2 = a + t * (b - a);
            f2 = y(F, x2);
        end
        n = n + 1;
    end
    
    xmin = (a + b) / 2;
    fmin = y(F, xmin);
end    

function fx = y(F, xi)
    fx = F(xi);  % Прямое вычисление для числовой функции
end

function [x1, x2] = x_solve(a, b)
    t1 = (3 - sqrt(5)) / 2;
    t2 = (sqrt(5) - 1) / 2;
    x1 = a + t1 * (b - a);
    x2 = a + t2 * (b - a);
end
