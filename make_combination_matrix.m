function L = make_combination_matrix(n)

L = sparse(zeros(nchoosek(n,2),n));

i=1;
for t=1:n
    for k=t+1:n
        L(i,t)=1;
        L(i,k)=-1;
        i=i+1;
    end
end

end