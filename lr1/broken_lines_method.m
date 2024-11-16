function [f_min, x_min,count] = broken_lines_method(f, a, b, tol) 
    % ����� ����� ��� ������ L
    num_points = 100;
    x_vals = linspace(a, b, num_points);
    f_vals = arrayfun(f, x_vals);
    % ������ ��������� ������� L
    L = 0;
    for j = 2:num_points
        L = max(L, abs(f_vals(j) - f_vals(j - 1)) / abs(x_vals(j) - x_vals(j - 1)));
    end

    % ��� 1: ��������� �������� x0 � y0
    x0 = (y(f, a) - y(f, b) + L * (a + b)) / (2 * L);
    y0 = (y(f, a) + y(f, b) - L * (b - a)) / 2;
    count = 2;
    % ��������� �������� ��� ������ ��������
    points = [a, x0, b];
    approximations = [y(f, a), y0, y(f, b)];

    % �������� ���� ������ ��������
    while true
        % ��� 2: ������� ����� � ����������� ��������� ���������������� �������
        [~, idx] = min(approximations);
        x_star = points(idx);
        p_star = approximations(idx);

        % ���������� �������� ������� � ����� ��������
        fx_star = y(f, x_star);
        count = count + 1;
        % ��� 3: ������ delta � delta_k ��� �������� ���������
        delta = (1 / (2 * L)) * (fx_star - p_star);
        delta_k = 2 * L * delta;

        % �������� ������� ��������
        if delta_k <= tol
            x_min = x_star;
            f_min = fx_star;
            break;
        end

        % ��� 4: ��������� ����� ����� (x' � x'') � ��������������� p' � p''
        x_prime = x_star - delta;
        x_double_prime = x_star + delta;
        
        % ���������� �������� p' � p''
        p_prime = 0.5 * (y(f, x_prime) + p_star);
        p_double_prime = 0.5 * (y(f, x_double_prime) + p_star);

        % ���������� ��������: ��������� ������ 3 ��������� �����
        points = [x_prime, x_star, x_double_prime];
        approximations = [p_prime, fx_star, p_double_prime];
    end
end

function fx = y(F, xi)
    fx = F(xi);
end
