function [Tr2,kp] = epoch_or(Tr1, cfg)
%elinimiates trials across all channels if a trial is greater than a
%treshold
%Example: 
   %orcfg.thres = 20;
   %[Tr2,kp] = epoch_or(Tr1, orcfg);

thres = cfg.thres;
kp_flag = ones(numel(Tr1.type),1);

for i=1:numel(Tr1.type)
        
    for j=1:numel(Tr1.idx)
        
        res = Tr1.data(i, :, j) > thres; %hard threshold        
        res = res + 0;
        
        if sum(res) > 0
            kp_flag(i) = 0;
            break;
        end
        
    end
    
end

rcfg.kp = find(kp_flag);
Tr2 = epoch_trs(Tr1, rcfg);
kp = rcfg.kp;