function [fmin,xmin] = perebor(F,a,b,eps)
    n = (b-a)/eps;                  %������� ����������� n ��� ���������� �������� ��������
    xi = linspace(a,b,n);
    f = subs(F,xi);
    plot(xi,f);
    grid on
    [fmin,ixmin] = min(f);
    xmin = xi(ixmin);