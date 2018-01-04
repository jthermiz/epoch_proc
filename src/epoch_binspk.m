function Tr2 = epoch_binspk(Tr, bin)
%bin number of spikes in windows of length bin specified in milliseconds
%Example:
    % n = 100e3;
    % Tr.data = rand(20,n,5)>0.9999;
    % Tr.time = linspace(-2,2,n);
    % Tr.fs = n/4;
    % Tr.idx = 1:20;

    %bin = 5; #   bin width in milliseconds
    %Tr2 = epoch_binspk(Tr,bin)
    %figure, imagesc(Tr2.data(:,:,1)*1.0)
    %colormap(flipud(bone))

Tr2 = Tr;
[n,len,d] = size(Tr.data);
binsamp = (bin/1000)*Tr.fs; %convert to samples
len2 = ceil(len/binsamp);
Tr2.data = zeros(n,len2,d);

%pad = zeros(mod(len,len2),1); %zero pad
sig = zeros(ceil(len/binsamp)*binsamp,1);
for i=1:d
    for j=1:n
        tmp = Tr.data(j,:,i);
        sig(1:len) = tmp(:);
        tmp2 = reshape(sig,binsamp,numel(sig)/binsamp);
        Tr2.data(j,:,i) = sum(tmp2);
    end
end

Tr2.time = linspace(Tr.time(1),Tr.time(end),len2);
Tr2.fs = 1/(bin/1000);

end