function [delta,s] = CrossVal( Name1,Name1L,Par1,Name2,Name2L,Par2,Pat,DOut,k )

% get groups for k-fold crossvalidation
cv = cvpartition(size(Pat,2),'KFold',k);

deltas = zeros(1, k);

for i = 1:k
    
    test = cv.test(i); % i-th group of testing indices
    train = cv.training(i); % i-th group of training indices
    
    E1 = Err(Name1, Name1L, Par1, Pat(:,train), DOut(train), Pat(:,test), DOut(test));
    E2 = Err(Name2, Name2L, Par2, Pat(:,train), DOut(train), Pat(:,test), DOut(test));
    
    deltas(i) = (E1 - E2);
    
end

delta = sum(deltas) / k;
s = sqrt((1/(k*(k-1))) * sum((deltas - delta) .^ 2)); 

end

