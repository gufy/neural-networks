function [ E ] = Err( Name, NameL, Par, Tr, DTr, Ts, DTs )

learn = str2func(Name);
recall = str2func(NameL);

LPar = learn(Tr, DTr, Par);
E = (1/size(Ts,2))*sum(recall( LPar, Ts ) ~= DTs);

end

