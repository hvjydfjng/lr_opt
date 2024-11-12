function [fmin, xmin, count] = parabols(F, a, b, eps)
    % ��������� ����� ������� �������� �������
    t = (sqrt(5)-1)/2;
    [x1, x2] = x_solve(a, b);
    x3 = b;
    count = 0;
     a0 = a;                           %��� �������� ������� � ������� ��������
    b0 = b;
    n = 1;
    while 1                           %��������� �������� �������� ������� ��� ������ ���������� �����
        if n == 1
            [x1,x2] = x_solve(a,b);
            f1 = y(F,x1);
            f2 = y(F,x2);
            curr_eps = (b-a)/2;
        end
        if ((a0 < x1) && (x1 < x2)) && ((y(F,a0) >= y(F,x1)) && (y(F,x1) <= y(F,x2)))
            x3 = x2;                %���� �� ���������� ��� ������ �������
            x2 = x1
            x1 = a;
            break; 
        end     
        if ((x1 < x2) &&(x2 < b0)) && ((y(F,x1) >= y(F,x2)) && (y(F,x2) <= y(F,b0)))
            x3 = b;                %���� �� ���������� ��� ������ �������
            x2 = x2
            x1 = x1;
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
    n = 1;
    
    % �������� ������� � ������
    f1 = y(F, x1);
    f2 = y(F, x2);
    f3 = y(F, x3);

    % ������������ �������
    while 1
        % ���������� ������������� ��������
        a1 = (f2 - f1) / (x2 - x1);
        a2 = 1 / (x3 - x2) * ((f3 - f1) / (x3 - x1) - (f2 - f1) / (x2 - x1));
        
        % ����� ����� ��������
        x_ = 0.5 * (x1 + x2 - a1 / a2);
        f_ = y(F, x_);
        count = count + 1;
        % ���������� ����� � ����������� �� ��������� ��������
        if x_ > x1 && x_ < x2
            if f_ < f2
                x3 = x2;
                f3 = f2;
                x2 = x_;
                f2 = f_;
            else
                x1 = x_;
                f1 = f_;
            end
        elseif x_ > x2 && x_ < x3
            if f_ < f2
                x1 = x2;
                f1 = f2;
                x2 = x_;
                f2 = f_;
            else
                x3 = x_;
                f3 = f_;
            end
        end

        % �������� �������� ���������
        if abs(x_ - x2) < eps
            break;
        end
    end

    xmin = double(x_);
    fmin = double(f_);
end

% ��������������� ������� ��� ���������� �������� �������
function [fx] = y(F, xi)
    fx = double(subs(F, xi));
end

% ��������������� ������� ��� ���������� ����� x1 � x2 ������� �������� �������
function [x1, x2] = x_solve(a, b)
    t = (sqrt(5) - 1) / 2;
    x1 = a + (3 - sqrt(5)) / 2 * (b - a);
    x2 = a + t * (b - a);
end
