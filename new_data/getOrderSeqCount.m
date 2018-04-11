function output = getOrderSeqCount(seq)
% this function takes in a sequence, and outputs a 2xN matrix.
% N is the number of unique consecutive elements in the sequence
% the first row of the output is the compressed sequence,
% the second row is the repition of the corresponding elements from the first row
xx = seq;
% xx = [6, 1, 1, 2, 2, 2, 4, 5]

[order index index2] = unique(xx);
o = 1:numel(order);
x = o(index2);
c = x(sort(index));
cc = xx(sort(index));

y = sort(x(:));
p = find([true;diff(y)~=0;true]);
values = y(p(1:end-1));
instances = diff(p);

output = [cc; instances(c)'];

end
