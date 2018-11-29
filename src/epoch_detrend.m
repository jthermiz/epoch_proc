function Tr = epoch_detrend(Tr)

[n,T,d] = size(Tr.data);

for i=1:n
    for j=1:d
        Tr.data(i,:,j) = detrend(Tr.data(i,:,j));
    end
end

end