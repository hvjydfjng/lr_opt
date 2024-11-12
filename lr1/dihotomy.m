function [fmin,xmin,count] = dihotomy(F,a,b,eps)
    n = (b-a)/(eps);                  %Задаём начальное значение шага для построения графика
    count = 0;
    delta = eps;                   %Начальное значение 
    while (b-a)/2 >= eps
        [x1, x2] = x_solve(a,b,delta);
        y1 = y(F,x1);
        y2 = y(F,x2);
        count = count + 2;
        if y1 <= y2
            b = x2;
        else
            a = x1;
        end
    end
    xmin = double((a+b)/2);
    fmin = double(y(F,xmin));
end    
    
    function [fx] = y(F,xi)
        fx = subs(F,xi);
    end

    function [x1,x2] = x_solve(a,b,del)
        x1 = (b+a-del)/2;
        x2 = (b+a+del)/2;
    end