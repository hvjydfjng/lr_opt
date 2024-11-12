function [fmin,xmin,count] = perebor(F,a,b,eps)
    n = (b-a)/eps;                  %Находим необходимое n для достижения заданной точности
    count = 0;
    xi = linspace(a,b,n);
    f = double(subs(F,xi));
    plot(xi,f);
    grid on
    count = length(f);
    [fmin,ixmin] = min(f);
    xmin = xi(ixmin);
    hold on
    plot(xmin, fmin, 'rx', 'MarkerSize', 8)
    title('Метод перебора - Минимум функции')
    xlabel('x')
    ylabel('f(x)')
    hold off
end