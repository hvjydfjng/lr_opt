function [fmin,xmin, count] = porazr(F,a,b,eps)
    n = (b-a)/(eps);                  %Задаём начальное значение шага для построения графика
    x_arr = linspace(a,b,n);
    plot(x_arr,y(F,x_arr));
    grid on;
    delta = 4*eps;                   %Начальное значение шага
    xi = a;
    count = 0;
    while delta >= eps
        [yi,xi,delta] = first_direction(F,xi,delta);
        [yi,xi,delta] = second_direction(F,xi,delta);
        count = count + 2;
    end
    fmin = double(yi);
    xmin = double(xi);
    end    
    function [fx] = y(F,xi)
        fx = subs(F,xi);
    end

    function [yi,xi_fin, del] = first_direction(F,xi_start,del)
        while y(F,xi_start) > y(F,xi_start+del) %Проверяем условие  
            xi_start = xi_start + del;
        end
        yi = y(F,xi_start);
        xi_fin = xi_start;
        del = del/2;
    end


    function [yi,xi_fin, del] = second_direction(F,xi_start,del)
        while y(F,xi_start) > y(F,xi_start-del) %Проверяем условие  
            xi_start = xi_start - del;
        end
        yi = y(F,xi_start);
        xi_fin = xi_start;
        del = del/2;
    end