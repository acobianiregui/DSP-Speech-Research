%% Project setup

repoRoot = fileparts(mfilename('fullpath'));

%% Add project source code
addpath(fullfile(repoRoot, 'src'));

%% Load local configuration
configFile = fullfile(repoRoot, 'config_local.m');

if ~isfile(configFile)
    error(['Missing config.local.m.' newline ...
        'Copy config.example.m to config.local.m ' ...
        'and specify the Aparat installation path.']);
end

run(configFile);

%% Check Aparat (download separately!)
if ~exist('APARAT_PATH', 'var') || ~isfolder(APARAT_PATH)
    error('APARAT_PATH is not configured correctly.');
end

addpath(genpath(APARAT_PATH));

fprintf('Project initialized.\n');
fprintf('Aparat: %s\n', APARAT_PATH);