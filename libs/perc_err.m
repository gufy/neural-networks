function [ out ] = perc_err( p, x, c )

out = sum(perc_recall( p, x ) ~= c);

end

