function [fmin, xmin,count] = newt_rafs(F, a, b, x0, eps)
    df = dy(F);
    ddf = dy(df);
    t = (y(df,x0)^2)/(y(df,x0)^2 + y(df,x0 - y(df,x0)/y(ddf,x0))^2);
    x_ = x0 - t*y(df,x0)/y(ddf,x0); % �� ������� ��������� ��� ����� ���������
    dfx_ = y(df, x_);
    count = 8;
    while abs(dfx_) > eps
         t = (y(df,x_)^2)/(y(df,x_)^2 + y(df,x_ - y(df,x_)/y(ddf,x_))^2);
         x_ = x_ - t*y(df,x_)/y(ddf,x_);
         dfx_ = y(df, x_);
         count = count + 8;
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