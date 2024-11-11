function [fmin,xmin] = parabols(F,a,b,eps)
    n = (b-a)/(eps);                  %Задаём начальное значение шага для построения графика
    x_arr = linspace(a,b,n);
    plot(x_arr,y(F,x_arr));
    grid on;
    t = (sqrt(5)-1)/2;
    n = 1;
    a0 = a;                           %Для проверки условия с концами отрезков
    b0 = b;
    while 1                           %Несколько итераций золотого сечения для поиска подходящих точек
        if n == 1
            [x1,x2] = x_solve(a,b);
            f1 = y(F,x1);
            f2 = y(F,x2);
            curr_eps = (b-a)/2;
        end
        if ((a0 < x1) && (x1 < x2)) && ((y(F,a0) >= y(F,x1)) && (y(F,x1) <= y(F,x2)))
            x3 = x2;                %Одно из неравенств для метода парабол
            x2 = x1
            x1 = a;
            break; 
        end     
        if ((x1 < x2) &&(x2 < b0)) && ((y(F,x1) >= y(F,x2)) && (y(F,x2) <= y(F,b0)))
            x3 = b;                %Одно из неравенств для метода парабол
            x2 = x2
            x1 = x1;
            break; 
        end      
        if f1 <= f2 && n > 1
            b = x2;
            x2 = x1;
            f2 = f1;
            x1 = b - t*(b-a);
            f1 = y(F,x1);
        end
        if f1 > f2 && n > 1
            a = x1;
            x1 = x2;
            f1 = f2;
            x2 = b - t*(b-a);
            f2 = y(F,x2);
        end
        n = n+1;
        curr_eps = curr_eps * t;
    end
    n = 1;
    %Получены начальные точки для метода парабол.
    x_ = y(F,x2);                    %Начальное значение для мнмимума
    x1_new = x1;
    x2_new = x2;
    x3_new = x3;
    while 1
        if n == 1
           f1 = y(F,x1);
           f2 = y(F,x2);
           f3 = y(F,x3);
        end
        a0 = f1;
        a1 = (f2-f1)/(x2-x1);
        a2 = 1/(x3-x2)*( (f3-f1)/(x3-x1) - (f2-f1)/(x2-x1));
        %Если х поменяли значение вычисляем новое f(x) и меняем значение х
        %Не знаю как но надо добавить проверку на равенство иксов
        if(x1 ~= x1_new)
            f1 = y(F,x1_new);
        end
        if(x2 ~= x2_new)
            f2 = y(F,x2_new);
        end
        if(x3 ~= x3_new)
            f3 = y(F,x3_new);
        end
        x_old = x_;
        x1 = x1_new;
        x2 = x2_new;
        x3 = x3_new;
        x_ = 1/2*(x1+x2-a1/a2);
        %Рассматриваем варианты точки минимума
        if x_ >= x1 && x_ < x2
            if y(F,x_) >= f2
                x1_new = x_;
            else
                x2_new = x_;
                x3_new = x_;
            end
        end
        if x_ <= x3 && x_ > x2
            if y(F,x_) >= f2
                x3_new = x_;
            else
                x1_new = x_;
                x2_new = x_;
            end        
        end
%        if x_ == x2
%            x2_new = x_;
%        end
        if abs(x_old - x_) < eps
            break;
        end
    n = n + 1;    
    end
    xmin = double(x_);
    fmin = double(y(F,xmin));
end
    function [fx] = y(F,xi)
        fx = subs(F,xi);
    end

    function [x1,x2] = x_solve(a,b)
        x1 = a+(3-sqrt(5))/2*(b-a);
        x2 = a+(sqrt(5)-1)/2*(b-a);
    end