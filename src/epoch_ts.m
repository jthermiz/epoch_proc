function Tr = epoch_ts(Tr, cfg)
%Example:
% tcfg.range = [-0.5 0.5];
% Tr3 = epoch_ts(Tr1, tcfg);

[~,st] = min(abs(cfg.range(1)-Tr.time));
[~,ed] = min(abs(cfg.range(2)-Tr.time));

Tr.time = Tr.time(st:ed);
Tr.data = Tr.data(:,st:ed,:);

if isfield(Tr,'time_target')
    [~,st] = min(abs(cfg.range(1)-Tr.time_target));
    [~,ed] = min(abs(cfg.range(2)-Tr.time_target));
    Tr.time_target = Tr.time_target(st:ed);
    Tr.target = Tr.target(:,st:ed);
end

end