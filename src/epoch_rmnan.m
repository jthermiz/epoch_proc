function Tr = epoch_rmnan(Tr)

kp = [];

for i=1:size(Tr.data,1)
    tmp = Tr.data(i,:,:);
    tmp2 = sum(tmp(:));
    if ~isnan(tmp2)
        kp = [kp i];
    end
end

ecfg.kp = kp;
Tr = epoch_trs(Tr,ecfg);

end