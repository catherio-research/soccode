function noise = createNoiseStimulus(sz, bpfilter, targetVar)
% CREATE NOISE STIMULUS
%   sz - the desired image size
%   bpfilter - the convolutional bandpass filter to use, in space domain
%   targetVar - the desired pixel variance of the pixels that are not
%       zero; this is a way to equate variance with a sparse stimulus

    noise = randn(sz, sz) - 0.5;
    noise = imfilter(noise, bpfilter, 'circular');

    % scale it to have the same variance as other categories *in the parts that
    % % aren't blank* in those categories:
    noiseVar = var(noise(noise ~= 0));
    contrastBoostNoise = sqrt(targetVar / noiseVar);

    noise = noise * contrastBoostNoise;
    noise(noise > 0.5) = 0.5;
    noise(noise < -0.5) = -0.5;
    % newVar = var(noise(noise ~= 0)); % check that truncation didn't ruin it
end