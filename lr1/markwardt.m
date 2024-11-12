function [fmin, xmin,count] = markwardt(F, a, b, x0, eps)
    df = dy(F);  % ������ �����������
    ddf = dy(df);  % ������ �����������
    
    u = 10 * abs(y(ddf, x0));  % ����������� ����������� ��������� �������� u
    x_ = x0 - y(df, x0) / (y(ddf, x0) + u);  % ������ ��������
    dfx_ = y(df, x_);  % ������ ����������� � ����� �����
    count = 4;
    while abs(dfx_) > eps
        if y(F, x0) >= y(F, x_)
            u = u / 2;  % ����������� u ������� ��� ������������
        else
            u = u * 2;  % ��������� u ������� ��� ����������
        end
        
        % ��������� ���������� �������� ����� ��� ������������ ����������
        x0 = x_;  
        x_ = x_ - y(df, x_) / (y(ddf, x_) + u);  % �������� ���������� x
        dfx_ = y(df, x_);  % ��������� �������� ������ �����������
        count = count + 3;
    end
    
    xmin = x_;
    fmin = y(F, xmin);
end    

function fx = y(F, xi)
    fx = double(subs(F, xi));
end

function df = dy(F)
    syms x
    df = diff(F, x);
end
