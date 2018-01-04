function Tr = epoch_base(Tr, cfg)
%subtract mean signal amplitude for each channel from entire signal (baseline)
%Example:
    %bscfg.range = [-0.5 0.01];
    %Tr2 = epoch_base(Tr1, bscfg);

Trb = epoch_ts(Tr,cfg);
for i=1:numel(Tr.idx)
    c = squeeze(mean(Trb.data(:,:,i),2));
    Tr.data(:,:,i) = Tr.data(:,:,i) - repmat(c,1,size(Tr.data,2));
end
end
        
