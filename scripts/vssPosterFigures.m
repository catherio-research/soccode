%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% VSS Analysis, all in one place! Easy to run, easy to find! %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loading the data!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% fMRI - which images
imNumsDataset = 70:225;
catToUse = {'pattern_space', 'pattern_central', 'grating_ori', ...
           'grating_contrast', 'plaid_contrast', 'circular_contrast', ...
           'pattern_contrast', ... % skip naturalistic ...
           'grating_sparse', 'pattern_sparse'}; % skip noise space/halves

load(fullfile(rootpath, 'code', 'visualization', 'stimuliNames.mat'), 'stimuliNames');
       
imIdxToUse = arrayfun(@(idx) strInCellArray(stimuliNames{idx}, catToUse), imNumsDataset);
imNumsToUse = imNumsDataset(imIdxToUse);

%% fMRI - betamn, both datasets
datasetNums = [3, 4];

datasets = {};
for ii = 1:length(datasetNums)
    dataset = ['dataset', num2str(datasetNums(ii), '%02d'), '.mat'];
    load(fullfile(rootpath, ['data/input/fmri_datasets/', dataset]),'betamn','betase', 'roi', 'roilabels');
    
    betaIdxToUse = arrayfun(@(x) find(imNumsDataset == x,1,'first'), imNumsToUse);
    betamnToUse = betamn(:, betaIdxToUse);
    betaseToUse = betase(:, betaIdxToUse);
    
    datasets{ii}.vals = betamnToUse;
    datasets{ii}.errs = betaseToUse;
    datasets{ii}.roi = roi;
    datasets{ii}.roilabels = roilabels;
end

%% ECoG - which images
load(fullfile(rootpath, 'code', 'visualization', 'stimuliNamesEcog.mat'), 'stimuliNamesEcog');
imIdxToUseEcog = find(arrayfun(@(idx) strInCellArray(stimuliNamesEcog{idx}, catToUse), 1:length(stimuliNamesEcog)));

%% ECoG - electrode data, one dataset
datasets{3}.electrodes = [108 109 115 120 121 107];

[ecog_vals, ecog_errs] = loadEcogBroadband(datasets{3}.electrodes);
datasets{3}.vals = ecog_vals(:, imIdxToUseEcog);
datasets{3}.errs = ecog_errs(:, imIdxToUseEcog, :);


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting empirical data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setupBetaFig;
bar(datasets{1}.vals(1, :));
addXlabels(imNumsToUse, stimuliNames);

setupBetaFig;
bar(datasets{3}.vals(1, :));
addXlabels(imIdxToUseEcog, stimuliNamesEcog);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Actual images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% View the ECoG images

ims = load(fullfile(rootpath, 'data', 'input', 'ecog_datasets', 'socforecog.mat'));

figure;
for ii = 1:size(ims.stimuli, 3)
    imshow(ims.stimuli(:,:,ii));
    title(ii);
    pause(0.5);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Category R2s
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Choose one canonical A and E
aOld = 0;
eOld = 1;

aNew = 0.5;
eNew = 4;

% avals = [0.25, 0.5, 0.75, 1];
% evals = [1, 2, 4, 8, 16]; 
% 
% for aNew = avals
%     for eNew = evals

categoryR2sOld = processGridSearchCategory(aOld, eOld);
categoryR2sNew = processGridSearchCategory(aNew, eNew);

figure; hold on;
unityline = linspace(0, 1, 100);
plot(unityline, unityline, 'k-');
plot(categoryR2sOld(categoryR2sOld > categoryR2sNew), categoryR2sNew(categoryR2sOld > categoryR2sNew), 'ro');
plot(categoryR2sOld(categoryR2sOld <= categoryR2sNew), categoryR2sNew(categoryR2sOld <= categoryR2sNew), 'go');
xlabel('Original'); ylabel('New');
title(['Category-specific R^2 ', num2str(aNew), ' ', num2str(eNew)]);

%     end
% end
