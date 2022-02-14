% BOLD correction for SS-VASO (Huber 2014)
% Nulled (VASO / TI1) and Non-nulled (BOLD / TI2)
%   - Surround division
% Icaro Oliveira Jan 2018
%% +++++++++++++++++++++++++++++++++++++++++
for sb = 1:parVASO.nsubs
    file_Nulled = spm_select('ExtFPList', parVASO.condirs{sb}, ['^rVASO.*\.nii'], 1:1000 );                        % SPM select file
    file_Not_Nulled = spm_select('ExtFPList', parVASO.condirs{sb}, ['^rBOLD.*\.nii'], 1:1000 );
    Nulled = spm_read_vols(spm_vol(file_Nulled));                                                                   % SPM read vols (header)
    Not_Nulled = spm_read_vols(spm_vol(file_Not_Nulled));
    [phase_dim,read_dim,slice_dim,t_dim]=size(Nulled);                                                              % matrix size
    %% BOLD correction using Nulled and Non-nulled images
    VASO = zeros(phase_dim,read_dim,slice_dim,t_dim);
    
    VASO(:,:,:,1) = Nulled(:,:,:,1)./ Not_Nulled(:,:,:,1);         % First Nulled divided by first non-nulled is the first VASO
    for i=2:t_dim-1
        VASO(:,:,:,i) = 2*Nulled(:,:,:,i)./(Not_Nulled(:,:,:,i-1) + Not_Nulled(:,:,:,i+1));    % Surround
    end
    VASO(:,:,:,t_dim) = Nulled(:,:,:,t_dim)./ Not_Nulled(:,:,:,t_dim);
    
    VASO(isinf(VASO))=0;
    VASO(isnan(VASO))=0;
    VASO(VASO<0)=0;
    VASO(VASO>5)=0;
    
    % Saving in 4D nifti format
    %   - non-masked
    for fseq=1:t_dim
        deltaCBV = spm_vol(file_Nulled(1,:));
        [preff] = spm_fileparts(file_Nulled(1,:));
        deltaCBV.fname = [preff filesep 'VASOp.nii'];
        deltaCBV.n = [fseq 1];
        deltaCBV.dt = [16 0];
        deltaCBV = spm_write_vol(deltaCBV,VASO(:,:,:,fseq));
    end

end