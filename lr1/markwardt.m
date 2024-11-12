function [fmin, xmin,count] = markwardt(F, a, b, x0, eps)
    df = dy(F);  % Первая производная
    ddf = dy(df);  % Вторая производная
    
    u = 10 * abs(y(ddf, x0));  % Значительно увеличиваем начальное значение u
    x_ = x0 - y(df, x0) / (y(ddf, x0) + u);  % Первая итерация
    dfx_ = y(df, x_);  % Первая производная в новой точке
    count = 4;
    while abs(dfx_) > eps
        if y(F, x0) >= y(F, x_)
            u = u / 2;  % Увеличиваем u быстрее при несходимости
        else
            u = u * 2;  % Уменьшаем u быстрее при сходимости
        end
        
        % Сохраняем предыдущее значение точки для отслеживания сходимости
        x0 = x_;  
        x_ = x_ - y(df, x_) / (y(ddf, x_) + u);  % Итерация обновления x
        dfx_ = y(df, x_);  % Обновляем значение первой производной
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
    df = diff(F, x);
end
