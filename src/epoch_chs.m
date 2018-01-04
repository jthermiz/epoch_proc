function Tr = epoch_chs(Tr, cfg)
%select a subset of channels specified by cfg.chs
%Example:
    % cfg.chs = [16 20 21 47 -23 24];
    % Tr2 = epoch_chs(Tr1,cfg);

ch_idx = ismember(Tr.idx, cfg.chs);

Tr.data = Tr.data(:,:,ch_idx);
Tr.idx = Tr.idx(ch_idx);
if isfield(Tr,'imp')
    Tr.imp = Tr.imp(ch_idx);
end
if isfield(Tr,'unit_type')
    Tr.unit_type = Tr.unit_type(ch_idx);
end



end