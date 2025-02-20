% Q1
array1 = [3, 7, 5, 2];
result1 = rats(array1(1)/array1(2)+array1(3)/array1(4));
string1 = '%d/%d+%d/%d=';
fprintf('Q1: %d/%d+%d/%d=%s\n', array1, result1);

% Q2
one = ones(1, 1000);
num = 1:1000;
num = one./num;
sum2 = sum(num);
fprintf('Q2: %0.4f\n', sum2);

% Q3
one = ones(1, 100);
num = 1:100;
num = one./cumprod(num);
sum3 = 1 + sum(num);
fprintf('Q3: %0.4f - %0.4f = %0.4f\n', sum3, exp(1), sum3-exp(1));

% Q4
fprintf('Q4:\n');
n4 = 5;
one = ones(n4);
one(1+2:n4-2, 1+2:n4-2) = 0;
disp(one);

% Q5
fprintf('Q5:\n');
n5 = 5;
array5 = 1: n5+1: n5*n5;
sequence = 1: 1: n5;
zero = zeros(n5);
zero(array5) = sequence;
disp(zero);

% Q6
fprintf('Q6:\n');
x = 1:3;
y = 1:5;
newx = repmat(x, length(y), 1);
newy = repmat(y', 1, length(x));
newxy = newx.^2 + newy.^2;
disp(newxy);