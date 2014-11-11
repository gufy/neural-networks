function [ np, I ] = perc_learn( p, x, c, lam, maxit )

np = p;

for I = 1:maxit

    np = perc_update(np, x, c, lam);
    E = perc_err(np, x, c);
   
    if E == 0
        break
    end
    
end

end

