function wgetData(overwrite)
% WGET DATA - This function fetches the stimuli and fMRI responses, which
% are not included in this git repository, and downloads them.
%   overwrite - if true, then will re-download and overwrite existing data,
%   if any exists

    if nargin < 1
        overwrite = false;
    end

    % Check if input directories exist
    datadir = fullfile(rootpath, 'data');
    if ~exist(datadir, 'dir')
        mkdir(datadir)
    end

    if ~exist(fullfile(datadir, 'input'), 'dir')
        mkdir(fullfile(datadir, 'input'))
    end
    if ~exist(fullfile(datadir, 'input', 'fmri_datasets'), 'dir')
        mkdir(fullfile(datadir, 'input', 'fmri_datasets'))
    end
    if ~exist(fullfile(datadir, 'input', 'conimages'), 'dir')
        mkdir(fullfile(datadir, 'input', 'conimages'))
    end

    % Set up output directories while we're at it
    if ~exist(fullfile(rootpath, 'modelfits'), 'dir')
        mkdir(fullfile(rootpath, 'modelfits'), 'dir')
    end
    if ~exist(fullfile(rootpath, 'preprocessing'), 'dir')
        mkdir(fullfile(rootpath, 'preprocessing'), 'dir')
    end

    %% Download; overwrite only if "overwrite" flag is on
    www = 'http://kendrickkay.net/socmodel/';

    stimuliName = 'stimuli.mat';
    stimuliLocation = fullfile(datadir, 'input', stimuliName);
    if (~exist(stimuliLocation, 'file') || overwrite)
        display('Downloading stimuli')
        urlwrite(fullfile(www, stimuliName), stimuliLocation);
    end

    for i = 1:5
        datasetName = ['dataset', num2str(i, '%02d'), '.mat'];
        datasetLocation = fullfile(datadir, 'input', 'fmri_datasets', datasetName);
        if (~exist(datasetLocation, 'file') || overwrite)
            display(['Downloading fMRI ', datasetName])
            urlwrite(fullfile(www, datasetName), datasetLocation);
        end
    end
end