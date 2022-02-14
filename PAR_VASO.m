% Batch mode scripts for VASO analysis
% running spm12
% This file sets up various specific details for the
% analysis, and stores them in the global variable par_VASO,
% which is used by the other batch files.
% ######################################
% March 2019, Icaro Oliveira

%% Global seetings %%
fprintf('\r%s\n',repmat(sprintf('-'),1,30))
fprintf('%-40s\n','set ssfpVASO')
fprintf('%-40s\n', 'Select main folder')
folder = uigetdir;

global parVASO

parVASO = [];
parVASO.SPM_path = spm('Dir');
parVASO.root = folder;
files = dir(parVASO.root); dirFlags = [files.isdir]; subj = files(dirFlags);
parVASO.nsubs = length(subj) - 2;

% Subjects directories
for y = 1:parVASO.nsubs
    parVASO.subjects(y) = {subj(2+y).name};
end

% getting condition directories and filenames of functional and structural
parVASO.structfolder = 'T123DEPI';
parVASO.confilters = 'funct';

parVASO.nonnulled = 'BOLD';
parVASO.nulled = 'VASO';
parVASO.pureVASO = 'VASOp';
parVASO.estimate_TRIAL = 1;

%% Select Images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get the anatomical image directories automatically
for sb=1:parVASO.nsubs
    tmp=dir(fullfile(parVASO.root,parVASO.subjects{sb},['*' parVASO.structfolder '*']));
    if size(tmp,1)==0
        sprintf('Can not find the anatomical directory for subject\n')
        sprintf('%s: \n', char(parVASO.subjects{sb}))
        error('Can not find the anatomical directory for subject');
    end
    if size(tmp,1)>1
        sprintf('More than 1 anatomical directories for subject: %s are found here!\n',char(parVASO.subjects{sb}))
        error('More than 1 anatomical directories are found')
    end
    parVASO.structdir{sb}=fullfile(parVASO.root,parVASO.subjects{sb},spm_str_manip(char(tmp(1).name),'d'));
end

% The condition names are assumed same for different sessions

for sb=1:parVASO.nsubs
    tmp=dir(fullfile(parVASO.root,parVASO.subjects{sb},['*' parVASO.confilters '*']));
    
    if size(tmp,1)==0
        sprintf('Can not find the condition directory for subject\n')
        sprintf('%s: \n', char(parVASO.subjects{sb}))
        error('Can not find the condition directory for subject');
    end
    
    if size(tmp,1)>1
        sprintf('Panic! subject %s has more than 1 directories!\n', [parVASO.subjects{sb}])
        error('Panic! condition has more than 1 directories!')
        %return;
    end
    parVASO.condirs{sb}=fullfile(parVASO.root,parVASO.subjects{sb},spm_str_manip(char(tmp(1).name),'d'));
end