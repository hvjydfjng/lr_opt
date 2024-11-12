function [fmin,xmin] = perebor(F,a,b,eps)
    n = (b-a)/eps;                  %Находим необходимое n для достижения заданной точности
    xi = linspace(a,b,n);
    f = subs(F,xi);
    plot(xi,f);
    grid on
    [fmin,ixmin] = min(f);
    xmin = xi(ixmin);
    hold on
    plot(xmin, fmin, 'rx', 'MarkerSize', 8)
    title('Метод перебора - Минимум функции')
    xlabel('x')
    ylabel('f(x)')
    hold off
end