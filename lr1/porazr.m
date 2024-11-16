function [fmin,xmin, count] = porazr(F,a,b,eps)
    n = (b-a)/(eps);                  %Задаём начальное значение шага для построения графика
    delta = 4*eps;                   %Начальное значение шага
    xi = a;
    count = 0;
    n = 0;
    while delta >= eps
        [yi,xi,delta,n] = first_direction(F,xi,delta,n);
        [yi,xi,delta,n] = second_direction(F,xi,delta,n);
    end
    fmin = double(yi);
    xmin = double(xi);
    count = n;
    end    
    function [fx] = y(F,xi)
        fx = subs(F,xi);
    end

    function [yi,xi_fin, del,n] = first_direction(F,xi_start,del,n)
        while y(F,xi_start) > y(F,xi_start+del) %Проверяем условие  
            xi_start = xi_start + del;
            n = n + 2;
        end
        yi = y(F,xi_start);
        xi_fin = xi_start;
        del = del/4;
    end


    function [yi,xi_fin, del,n] = second_direction(F,xi_start,del,n)
        while y(F,xi_start) > y(F,xi_start-del) %Проверяем условие  
            xi_start = xi_start - del;
            n = n + 2;
        end
        yi = y(F,xi_start);
        xi_fin = xi_start;
        del = del/4;
    end