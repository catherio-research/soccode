function [plotOrder, plotNames, catColors] = getJunePlotInfo()
% GET JUNE PLOT INFO - Get the ordering, reordering, and colors, for
% the June 2015 data.

% Give category names to each image, according to the order they were collected
patterns_sparse = 1:5;
gratings_sparse = 6:10;
noisebars_sparse = 11:15;
waves_sparse = 17:21; % 16 is just toooo sparse
gratings_ori = [8, 22:24];
noisebars_ori = [13, 25:27];
waves_ori = [20, 28:30];
gratings_cross = [31, 32, 10, 33, 34, 8];
gratings_contrast = [35:36, 8, 37:38];
noisebars_contrast = [39:40, 13, 41:42];
waves_contrast = [43:44, 18, 45:46];
patterns_contrast = [47:48, 3, 49:50];

% Establish a canonical display order
plotOrder = [patterns_sparse, gratings_sparse, noisebars_sparse, waves_sparse, ...
             gratings_ori, noisebars_ori, waves_ori ...
             gratings_cross, ...
             patterns_contrast, gratings_contrast, noisebars_contrast, waves_contrast];
         
plotNames = [repmat({'patterns_sparse'}, length(patterns_sparse), 1); ...
 repmat({'gratings_sparse'}, length(gratings_sparse), 1); ...
 repmat({'noisebars_sparse'}, length(noisebars_sparse), 1); ...
 repmat({'waves_sparse'}, length(waves_sparse), 1); ...
 ...
 repmat({'gratings_ori'}, length(gratings_ori), 1); ...
 repmat({'noisebars_ori'}, length(noisebars_ori), 1); ...
 repmat({'waves_ori'}, length(waves_ori), 1); ...
 ...
 repmat({'gratings_cross'}, length(gratings_cross), 1); ...
 ...
 repmat({'patterns_contrast'}, length(patterns_contrast), 1); ...
 repmat({'gratings_contrast'}, length(gratings_contrast), 1); ...
 repmat({'noisebars_contrast'}, length(noisebars_contrast), 1); ...
 repmat({'waves_contrast'}, length(waves_contrast), 1)];

gratingsColor = [80, 130, 220] ./ 255; % blue
noisebarsColor = [120, 98, 86] ./ 255; % brown
wavesColor = [0, 115, 130] ./ 255; % green
patternsColor = [80, 40, 140] ./ 255; % purple

% not in plot order; needs to be reordered:
catColors = [repmat(patternsColor, length(patterns_sparse), 1); ...
 repmat(gratingsColor, length(gratings_sparse), 1); ...
 repmat(noisebarsColor, length(noisebars_sparse), 1); ...
 repmat(wavesColor, length(waves_sparse)+1, 1); ...
 ...
 repmat(gratingsColor, length(gratings_ori)-1, 1); ... % these -1 are to remove repeated categories
 repmat(noisebarsColor, length(noisebars_ori)-1, 1); ...
 repmat(wavesColor, length(waves_ori)-1, 1); ...
 ...
 repmat(gratingsColor, length(gratings_cross)-2, 1); ...
 ...
 repmat(gratingsColor, length(gratings_contrast)-1, 1); ...
 repmat(noisebarsColor, length(noisebars_contrast)-1, 1); ...
 repmat(wavesColor, length(waves_contrast)-1, 1); ...
 repmat(patternsColor, length(patterns_contrast)-1, 1)];