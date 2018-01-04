function data = epoch_flatten(Tr)
%flatten the 3D matrix of numbers from trials x samples x channels --> channels x samples
%Example
%	data = epoch_flatten(TR);

[n,T,d] = size(Tr.data);
data = permute(Tr.data,[2 3 1]);
data = reshape(data,d,n*T);


