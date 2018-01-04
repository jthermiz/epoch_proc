function Tr = epoch_proc(Tr, fun)
%Example:
    % fun = @(x) abs(hilbert(x));
    % Tr = epoch_proc(Tr, fun, []);

Tr.data = permute(Tr.data, [2 1 3]);
sz = size(Tr.data);
%proc 
Tr.data = fun(Tr.data(:));

Tr.data = permute(reshape(Tr.data,sz), [2 1 3]);