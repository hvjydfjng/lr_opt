function [fmin, xmin, count] = newton_centr(F, a, b, x0, eps)
    h = 1e-6;  % ��� ��� ���������� ���������� �����������
    count = 0;

    % ��������� ���������� ������ � ������ ����������� � ��������� �����
    df = numerical_derivative(F, x0, h);
    ddf = numerical_second_derivative(F, x0, h);

    % �� ������� ��������� ������ ����� ��������
    x_ = x0 - df / ddf;
    dfx_ = numerical_derivative(F, x_, h);
    count = count + 7; % ��������� ��� ������ ������� �� ��������� ��������

    while abs(dfx_) > eps
        % ������������� ������ � ������ �����������
        df = numerical_derivative(F, x_, h);
        ddf = numerical_second_derivative(F, x_, h);
        
        % ��������� ����� ��������
        x_ = x_ - df / ddf;

        % ������������� ����������� � ����� �����
        dfx_ = numerical_derivative(F, x_, h);
        count = count + 7; % ������ �������� ������� 3 ������� �������
        if count > 3000
            disp('����� ������� �� ��������, ���������� ������ ��������� �����������')
             break;
         end
    end

    xmin = x_;
    fmin = F(xmin);
end

% ��������� ���������� ������ ����������� (����������� ��������)
function df = numerical_derivative(F, x, h)
    df = (F(x + h) - F(x - h)) / (2 * h);
end

% ��������� ���������� ������ ����������� (����������� ��������)
function ddf = numerical_second_derivative(F, x, h)
    ddf = (F(x + h) - 2 * F(x) + F(x - h)) / (h^2);
end
