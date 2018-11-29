function Tr = epoch_trs(Tr, cfg)
%Example:
    % cfg.kp = [1:10 15:20];
    % Tr = epoch_trs(Tr.cfg);

kp = cfg.kp;

Tr.data = Tr.data(kp,:,:);
Tr.atime = Tr.atime(kp);
Tr.type = Tr.type(kp);
if and(isfield(Tr,'target'),0) %bypass for now
    Tr.target = Tr.target(kp,:);
end

if isfield(Tr,'gtime')
    Tr.gtime = Tr.gtime(kp);
end
end