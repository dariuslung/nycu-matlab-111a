test1 = SparsePoly([1 2 3], [4 5 6]);
test2 = SparsePoly([1 2 4], [3 3 1]);
test3 = SparsePoly([1 2 3], [1 2 3]);
test4 = SparsePoly();
a = [test1 test2];
b = [test2 test3];
c = [test1 test2; test3 test4];
X = 1:5;
% SparsePoly([1 2 3], [1 -1 2])
% a + b
% a - b
% test1.*a
% a.*b
% test4.eval(X)
% c.plot(X)