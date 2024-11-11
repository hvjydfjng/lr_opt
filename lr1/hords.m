function [fmin, xmin] = hords(F, a, b, eps)
    df = dy(F)
    x_ = a - y(df,a)/(y(df,a) - y(df,b))*(a-b); % �� ������� ��������� ��� ����� ���������
    dfx_ = y(df, x_);
    
    while abs(dfx_) > eps
        if dfx_ > 0
            b = x_;
        else
            a = x_;
        end
        x_ = a - y(df,a)/(y(df,a) - y(df,b))*(a-b);
        dfx_ = y(df, x_);
    end
    xmin = x_;
    fmin = y(F, xmin);
end    

function fx = y(F, xi)
    fx = double(subs(F, xi));
end

function df = dy(F)
    syms x
    df = diff(F,x);
end
