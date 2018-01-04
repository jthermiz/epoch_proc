function Tr = epoch_ds(Tr,cfg)
%downsample by specifing downsample factor as cfg.ds
%Example:
%	cfg.ds = 2;
%	Tr = epoch_ds(Tr,cfg)

ds = cfg.ds;

Tr.data = Tr.data(:,1:ds:end,:);
Tr.time = Tr.time(1:ds:end);
Tr.fs = Tr.fs/ds;