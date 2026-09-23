function [g, info] = estimate_glottal_flow(x, fs,f0)
%ESTIMATE_GLOTTAL_FLOW Estimate glottal flow using Aparat IAIF.
%
%   [g, info] = estimate_glottal_flow(x, fs)
%
%   Inputs:
%       x  - Speech signal
%       fs - Sampling frequency in Hz
%       f0 - Fundamental frequency
%
%   Outputs:
%       g    - Estimated glottal flow
%       info - Structure containing IAIF intermediate results
%
%   IAIF settings are chosen to reproduce the methodology
%   described by Torres (2010) where possible.

arguments
    x (:,1) double
    fs (1,1) double {mustBePositive}
    f0 (1,1) double {mustBePositive}
end

%IAIF parameters

opts = struct();

%following thesis -> p = 16
opts.p = 16;

% Aparat IAIF default glottal model order
opts.g = 4;

% Aparat integration coefficient
opts.rho = 0.99;

% Use Discrete All-Pole modeling
opts.arfunc = 'dap';

% Return integrated glottal flow rather than derivative
opts.diffout = 0;

if ~isscalar(f0) || ~isfinite(f0) || f0 <= 0
    error('f0 must be a positive scalar frequency in Hz.');
end

%run iaif function

[g, Hvt2, e_ar, Hg2] = iaif(x, fs, opts);

%return the info in case its needed

info.Hvt2 = Hvt2;
info.error = e_ar;
info.Hg2 = Hg2;

end