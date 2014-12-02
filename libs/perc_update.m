function operc = perc_update(perc, in, out, lam)

num = size(in, 2);

myperc = perc;

for ind = 1:num
   col = in(:, ind);
   actual = perc_recall(myperc, col);
   sign = out(ind) - actual;
   myperc = myperc + (sign * lam * [col;1])';
end

operc = myperc;

end