uses CRT;

function f(x: real): real;
begin
  Result := 2 * Power(x, 3) + Power(x, 2) + 3;
end;

function F1(x: real): real;
begin
  Result := Power(x, 4) / 2.0 + Power(x, 3) / 3.0 + 3 * x;
end;

function reference(a, b: real): real;
begin
  Result := F1(b) - F1(a);
end;

function average(a, b: real; N: integer): real;
var
  h, sum, x: real;
begin
  h := (b - a) / N;
  sum := 0.0;
  for var i := 0 to N - 1 do
  begin
    x := a + (i + 0.5) * h;
    sum := sum + f(x);
  end;
  Result := h * sum;
end;

function symbolscaner(str: string): integer;
begin
  for var d := 1 to Length(str) do
    if ((str[d] >= '0') and (str[d] <= '9')) or (str[d] = '.') or (str[d] = ',') then
    begin
      Result := 0;
      exit;
    end;
  Result := 1;
end;

var
  first, second, third, temp: string;
  a, b: real;
  resultInt, res_ref, absolute, otnosit: real;
  flag_1, flag_2, flag_3: integer;
  choice, N, code: integer;

begin
  a := 0.0;
  b := 0.0;
  flag_1 := 0;
  flag_2 := 0;
  flag_3 := 0;
  N := 0;

  while true do
  begin
    ClrScr;
    writeln('Функция: 2*x^3 + x^2 + 0*x + 3');
    writeln('Корень функции: -1,3');
    writeln('Меню:');
    writeln('1. Нижний предел интегрирования: ', a:0:5);
    writeln('2. Верхний предел интегрирования: ', b:0:5);
    writeln('3. Количество шагов: ', N);
    writeln('4. Вычисление');
    writeln('5. Выход');
    write('Введите номер пункта: ');
    readln(temp);

    if symbolscaner(temp) <> 0 then
      choice := 0
    else
    begin
      Val(temp, choice, code);
      if code <> 0 then
        choice := 0;
    end;

    case choice of
      1:
        begin
          write('Введите нижний предел интегрирования: ');
          readln(first);

          for var i := 1 to Length(first) do
            if first[i] = '.' then
            begin
              first[i] := ',';
              break;
            end;

          if symbolscaner(first) <> 0 then
          begin
            writeln('Ошибка! Строка содержит недопустимые символы!');
            readln;
            continue;
          end;

          Val(first, a, code);
          if code <> 0 then
          begin
            writeln('Ошибка преобразования числа!');
            readln;
            continue;
          end;

          if a < -1.3 then
          begin
            writeln('Ошибка! Нижний предел интегрирования не может быть меньше -1.3!');
            readln;
            a := -1.3;
            flag_1 := 1;
            continue;
          end;
          flag_1 := 1;
        end;

      2:
        begin
          write('Введите верхний предел интегрирования: ');
          readln(second);

          for var i := 1 to Length(second) do
            if second[i] = '.' then
            begin
              second[i] := ',';
              break;
            end;

          if symbolscaner(second) <> 0 then
          begin
            writeln('Ошибка! Строка содержит недопустимые символы!');
            readln;
            continue;
          end;

          Val(second, b, code);
          if code <> 0 then
          begin
            writeln('Ошибка преобразования числа!');
            readln;
            continue;
          end;

          if b < -1.3 then
          begin
            writeln('Ошибка! Верхний предел интегрирования не может быть меньше -1.3!');
            readln;
            b := -1.29;
            flag_2 := 1;
            continue;
          end;
          flag_2 := 1;
        end;

      3:
        begin
          write('Введите количество шагов: ');
          readln(third);

          for var i := 1 to Length(third) do
            if third[i] = '.' then
            begin
              third[i] := ',';
              break;
            end;

          if symbolscaner(third) <> 0 then
          begin
            writeln('Ошибка! Строка содержит недопустимые символы!');
            readln;
            continue;
          end;

          Val(third, N, code);
          if (code <> 0) or (N = 0) then
          begin
            writeln('Ошибка!Количество шагов не должно быть равно нулю!');
            readln;
            continue;
          end;
          if N < 0 then
          begin
            writeln('Ошибка! Количество шагов должно быть больше нуля!');
            readln;
            continue;
          end;

          flag_3 := 1;
        end;

      4:
        begin
          if (flag_1 = 0) or (flag_2 = 0) or (flag_3 = 0) then
          begin
            writeln('Проверьте введённые данные! Введены не все пункты!');
            readln;
            continue;
          end;

          if a > b then
          begin
            writeln('Ошибка! Нижный предел должен быть больше верхнего!');
            readln;
            continue;
          end
          else if a = b then
          begin
            writeln('Ошибка! Пределы интегрирования не должны быть равны!');
            readln;
            continue;
          end;

          resultInt := average(a, b, N);
          res_ref := reference(a, b);
          absolute := Abs(res_ref - resultInt);
          otnosit := (absolute / res_ref) * 100.0;

          ClrScr;
          writeln('Площадь фигуры, вычисленная методом средних прямоугольников: ', resultInt:0:3);
          writeln('Площадь фигуры, вычисленная методом Ньютона-Лейбница: ', res_ref:0:3);
          writeln('Абсолютная погрешность: ', absolute:0:3);
          writeln('Относительная погрешность: ', otnosit:0:3, '%');
          readln;
        end;

      5:
        begin
          writeln('Завершение программы');
          exit;
        end;

      else
        begin
          writeln('Некорректный ввод!');
          readln;
        end;
    end;
  end;
end.
