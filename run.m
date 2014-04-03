% Generate impulse response of the system

c        = 340;                   % Sound speed
fs       = 44100;                 % Sampling frequency
source   = [2 3 1];               % Source positions [x y z] (m)
receiver = [4.23 3 1; 2 0.77 1];  % Receiver positions [x y z] (m)
L        = [5 4 1];               % Room dimensions
beta     = [0.15 0.30 0.50];      % T60 - Reverberation Time

snr = 15; % Noise to be added

% Load speech signal
t = 0:.0001:5;
speech = sin(2*pi*t); % sine for now

%--------- beta = 0.15 ---------
[sig1 sig2] = generate(c, fs, source, receiver, L, beta(1), speech, snr);
tau = gcc_phat(sig1, sig2);
% tau_prime = finddelay(sig1, sig2); % Exists in matlab itself
[lag I] = mi(sig1, sig2, 10, 4, 2);