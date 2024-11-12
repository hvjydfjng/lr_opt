function [fmin,xmin,count] = perebor(F,a,b,eps)
    n = (b-a)/eps;                  %������� ����������� n ��� ���������� �������� ��������
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
    title('����� �������� - ������� �������')
    xlabel('x')
    ylabel('f(x)')
    hold off
end