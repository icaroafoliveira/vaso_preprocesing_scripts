% Motion correction
% using SPM12 spm_realign
% Batch realign VASO
% Icaro Oliveira Jan 2018
%% +++++++++++++++++++++++++
parVASO;

disp('We are now realigning raw EPI and VASO images seperately')

% global defaults;
% spm_defaults;
% 
% % Get the realignemnt defaults
% defs = defaults.realign;
% 
% % Flags // realignment parameters
% % default

reaFlags = struct(...
    'quality', 1,...                      % estimation quality
    'sep', 2,...                          % separation
    'fwhm', 1,...                         % smooth before calculation
    'rtm', 1,...                          % 1, whether to realign to mean
    'PW',''...                            %
    );

% Flags to pass to routine to create resliced images
% (spm_reslice)
resFlags = struct(...
    'interp', 4,...                         % trilinear interpolation
    'wrap', [0 0 0],...                     % wrapping info (ignore...)
    'mask', 1,...                           % masking (see spm_reslice)
    'which',[2 1],...                       % write reslice time series for later use
    'mean',1);                              % do write mean image

% Huber recommendation (HighRes)
% -quality = 1
% -fwhm = 1
% -sep = 1.2
% -interp = 4


for sb = 1:parVASO.nsubs
    str = sprintf('sub #%3d/%3d: %-5s', sb, parVASO.nsubs, parVASO.subjects{sb});
    fprintf('\r%-40s %30s', str, '')
    P=[];
    
    Nulled = spm_select('ExtFPList', parVASO.condirs{sb}, ['^' parVASO.nulled '\w*\.nii$'], 1:1000 );
    Not_Nulled = spm_select('ExtFPList', parVASO.condirs{sb},['^' parVASO.nonnulled '\w*\.nii$'], 1:1000  );
    P = {Nulled,Not_Nulled};
    for ncond=1:2 %size(P,2)
        spm_realign(P{ncond},reaFlags);
        spm_reslice(P{ncond},resFlags);
    end
end