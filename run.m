function [rmse_mi, rmse_gcc] = run(order, L, T60)
% Run both GCC-PHAT and MI based delay calculaters and return RMS errors
%
%
% Author: Jayesh Kumar Gupta, Arpit Jangid, 2014.
%
% Contact: Jayesh Kumar Gupta http://rejuvyesh.com
%          Indian Institute of Technology, Kanpur, India

    c        = 340;                  % Sound speed
    fs       = 44100;                % Sampling frequency
    source   = [2 3 1];              % Source positions [x y z] (m)
    receiver = [4.23 3 1; 2 0.77 1]; % Receiver positions [x y z] (m)
    D        = [5 4 1];              % Room dimensions [x y z] (m)
    snr      = 15;                   % Noise to be added

    % Actual delay
    tau_actual  = 7;

    % Initialize sums
    sigma_t_gcc = 0;
    sigma_t_mi  = 0;
    
    % male speech file
    fname={'mike.wav'};
    
    % Find impulse function for the room
    h = rir_generator(c, fs, receiver, source, D,T60);
    % Divide into 10 frames
    frame = floor(L/10);

    for i = 1 : 10
        % Load speech file
        speech = wav2sig(fname,fs);

        % Generate the signal by convoluting with impulse response of the
        % room and adding noise
        [sig1, sig2] = generate(h,speech, snr);

        % Actually divide into frames
        sig1 = sig1(1+frame*(i-1):frame*i);
        sig2 = sig2(1+frame*(i-1):frame*i);

        % Find GCC-PHAT delay
        tau_gcc = gcc_phat(sig1, sig2);

        % Find mutual information based delay
        tau_mi = mi(sig1, sig2, 10, order, 2);

        % Calculate summation of square errors
        sigma_t_gcc = sigma_t_gcc + (tau_actual - tau_gcc)^2;   
        sigma_t_mi  = sigma_t_mi + (tau_actual - tau_mi)^2;
    end

    % Calculate root mean square values
    sigma_t_gcc = sigma_t_gcc/10;
    rmse_gcc    = sqrt(sigma_t_gcc);
    sigma_t_mi  = sigma_t_mi/10;
    rmse_mi     = sqrt(sigma_t_mi);
end