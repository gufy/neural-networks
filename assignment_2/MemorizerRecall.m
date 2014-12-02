function Out = MemorizerRecall(LPar,In)

Known = LPar{1};
KnownOut = LPar{2};
j=1;
Out = zeros(1,size(In,2));
for i = 1:size(In,2)
    j=1;
    while j<=size(Known,2)
        if In(:,i)==Known(:,j)
            break
        else
            j=j+1; 
        end
    end
    
    if j<=size(Known,2)
      Out(i) = KnownOut(j);
    else
      Out(i) = rand(1)>0.5;
    end
end

end