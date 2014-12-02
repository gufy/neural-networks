function res = perc_recall(p,x)

res = p*[x; ones(1, size(x,2))] >= 0;

end