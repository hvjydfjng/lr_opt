function [fmin,xmin,count] = perebor(F,a,b,eps)
    n = (b-a)/eps;                  %Находим необходимое n для достижения заданной точности
    count = 0;
    xi = linspace(a,b,n);
    f = double(subs(F,xi));
    count = length(f);
    [fmin,ixmin] = min(f);
    xmin = xi(ixmin);
end