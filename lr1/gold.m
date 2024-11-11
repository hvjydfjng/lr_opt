function [fmin,xmin] = gold(F,a,b,eps)
    n = (b-a)/(eps);                  %Задаём начальное значение шага для построения графика
    x_arr = linspace(a,b,n);
    plot(x_arr,y(F,x_arr));
    grid on;
    t = (sqrt(5)-1)/2;
    n = 1;
    while 1
        if n == 1
            [x1,x2] = x_solve(a,b);
            f1 = y(F,x1);
            f2 = y(F,x2);
            curr_eps = (b-a)/2;
        end
        if curr_eps < eps
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
    xmin = double((a+b)/2);
    fmin = double(y(F,xmin));
end    
    
    function [fx] = y(F,xi)
        fx = subs(F,xi);
    end

    function [x1,x2] = x_solve(a,b)
        x1 = a+(3-sqrt(5))/2*(b-a);
        x2 = a+(sqrt(5)-1)/2*(b-a);
    end