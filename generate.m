% Generate impulse response of the system

c        = 340;                   % Sound speed
fs       = 44100;                 % Sampling frequency
source   = [2 3 1];               % Source positions [x y z] (m)
receiver = [4.23 3 1; 2 0.77 1];  % Receiver positions [x y z] (m)
L        = [5 4 1];               % Room dimensions
beta     = [0.15 0.30 0.50];      % T60 - Reverberation Time

% Modified for non-integer?

for i = 1:3
    h{i} = rir_generator(c, fs, receiver, source, L, beta(i))
end

% Load speech signal
t = 0:.0001:5;
speech = sin(2*pi*t); % sine for now

% Now convolve h with speech signal

for i = 1:3
    for j = 1:2
        x{i}(j,:) = conv(h{i}(j,:), speech);
    end 
end

% Add noise to the convolved signal

for i = 1:3
    for j = 1:2
        x{i}(j,:) = awgn(x{i}(j,:), 15)
    end 
end
