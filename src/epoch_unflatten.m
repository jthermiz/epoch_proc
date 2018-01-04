function dataOut = epoch_unflatten(dataIn,shape)
%accepts dataIn: channels x trials*samples
%        shape: trials x samples x channels (number)
%returns dataOut: trials x samples x channels
%not memory efficient

n = shape(1);
T = shape(2);
d = shape(3);

dataOut = zeros(n,T,d);

for i=1:d
   dataOut(:,:,i) = reshape(dataIn(i,:),n,T);    
end



