function Tr = epoch_kwd(kwdfile,stim,cfg)
%Example:
    % kwdfile = 'experiment.kwd';
    % kwefile = 'experiment.sng'kwe';
    % cfg.range  = [-2 2];
    % cfg.rhd_convert = 0;
    % Tr = epoch_kwd(kwdfile, cfg);

%Note for some reason h5read is super slow with stride > 1, so ignoring
%eliminating this an input

%raw recording metadata
%raw recording metadata
info = h5info(kwdfile,'/recordings/0');
chtot = info.Datasets(1).Dataspace.Size(1);
fs = info.Attributes(2).Value(1); 
convfactor = 0.195; %hardcorded since it never changes

% if cfg.rhd_convert -- DELETE SOON
%     convfactor = info.Groups.Attributes(3).Value(1); 
%     fs = info.Groups.Attributes(2).Value(1); %assume sample rate the same for all channels
% else    
%     convfactor = info.Groups.Attributes(1).Value(1); %assume conversion factor the same for all channels
%     %convfactor = h5read(kwdfile,'/recordings/0/application_data/channel_bit_volts');
%     convfactor = convfactor(1);
%     fs = info.Attributes(2).Value(1); %assume sample rate the same for all channels
%     %fs = info.Attributes(4).Value(1); %assume sample rate the same for all channels
% end

fs = double(fs); %raw data sample rate
convfactor = double(convfactor);

%event information
trnum = numel(stim.atime);
stim_num = numel(stim.typename);
for i=1:stim_num
    Tr.typename{i} = stim.typename{i};
end

%init Tr struct
Tr.fs = fs; %read sampled rate
T = round((cfg.range(2) - cfg.range(1))*Tr.fs); %trial length in samples
Tr.data = zeros(trnum,T,chtot);
Tr.time = linspace(cfg.range(1),cfg.range(2),T);
Tr.idx = 1:chtot;
Tr.type = zeros(trnum,1);
Tr.atime = zeros(trnum,1);


% main Tr loop
z = 1;
for i=1:stim_num
    idx = stim.type == i;
    ev = stim.atime(idx);
    for j=1:numel(ev)
        tic
        a = ev(j) + cfg.range(1)*fs;        
        startindices = [1, a];        
        countindices = [chtot, T];
        dat = h5read(kwdfile,'/recordings/0/data',startindices,countindices);        
        Tr.data(z,:,:) = single(dat')*convfactor;
        Tr.type(z) = i;
        Tr.atime(z) = ev(j);
        z = z + 1;
        toc
    end
end


end

