function Tr = epoch_continous(A, cfg)
%convert continuous data structure to trialized data structure. 
%This is done by thresholding trigger line A.adc to find trial onset times. 
%cfg.range is used to specific the window of the trial about the onset time.
%Example:
    % ecfg.range  = [-2 2];
    % Tr = epoch_continous(A, ecfg);

%Trialize data based on adc

pre = -1*cfg.range(1)*A.fs; %convert to samples
post = cfg.range(2)*A.fs; %convert to samples
n = pre + post;
thres = max(A.adc)/2;


x = (A.adc - thres);
x1 = x.*[x(2:end) 0];
y = find(and(x1 < 0, x < 0));

ch_num = size(A.data,1);
tr_num = numel(y);

Tr.data = nan(tr_num,n,ch_num);
Tr.time = linspace(cfg.range(1),cfg.range(2),n);
Tr.atime = nan(tr_num,1);
Tr.type = zeros(tr_num,1);
Tr.idx = A.idx;
Tr.imp = A.imp;
Tr.fs = A.fs;


for i=1:tr_num
    
    a = y(i)-pre;
    b = y(i)+post-1;
    try
        Tr.data(i,:,:) = A.data(:,a:b)';
    catch
        disp('err')
    end
    Tr.atime(i) = A.time(y(i));   
    
end

%remove all invalid trials
rcfg.kp = ~isnan(Tr.data(:,1,1));
Tr = epoch_trs(Tr, rcfg);