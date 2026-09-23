clear;
clc;
close all;

%% Repository setup

experimentsDir = fileparts(mfilename('fullpath'));
repoRoot = fileparts(experimentsDir);

run(fullfile(repoRoot, 'setup.m'));

%% Load test recording

audioFile = fullfile(repoRoot, 'data', 'eeee_audio.wav');

[x, fs] = audioread(audioFile);

%% Convert stereo to mono if needed

if size(x,2) > 1
    x = mean(x,2);
end

x = x(:);

%% Resample to 16 kHz if needed

if fs ~= 16000
    x = resample(x, 16000, fs);
    fs = 16000;
end

%% Estimate glottal flow
f0 = median(pitch(x, fs)); % provisional!!!!!!!!!!!!!!!!!!!!!!!!!!!!
[g, info] = estimate_glottal_flow(x, fs,f0);

%% Plot

tSpeech = (0:length(x)-1) / fs;
tGlottal = (0:length(g)-1) / fs;

figure;

plot(tSpeech, x);
hold on;
plot(tGlottal, g);

xlabel('Time (s)');
ylabel('Amplitude');
legend('Speech', 'Estimated glottal flow');
title('IAIF Glottal Flow Estimate');
grid on;