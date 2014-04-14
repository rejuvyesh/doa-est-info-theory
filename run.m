function [rmse_mi, rmse_gcc] = run(order, L, T60)
% Run both GCC-PHAT and MI based delay calculaters and return RMS errors
%
% Input: 
% order - order mi (N)
% L     - block length
% T60   - reverberation time
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
    no_frame = 10;
    frame = floor(L/no_frame);

    % Load speech file
    speech = wav2sig(fname,fs);
        
    % Generate the signal by convoluting with impulse response of the
    % room and adding noise
    [sig1h, sig2h] = generate(h,speech, snr);

    for j = 1:length(sig1h)/10    
        for i = 1 : no_frame

            % Actually divide into frames
            sig1 = sig1h(1, 1+frame*(i+j-2):frame*(i+j-1));
            sig2 = sig2h(1, 1+frame*(i+j-2):frame*(i+j-1));

            % Find GCC-PHAT delay
            tau_gcc(i) = gcc_phat(sig1, sig2);

            % Find mutual information based delay
            range_of_tau = 10;
            tau_mi(i) = mi(sig1, sig2, range_of_tau, order, 2);
        end
        tau_gcc = sum(tau_gcc(:))/length(tau_gcc);
        tau_mi  = sum(tau_mi(:))/length(tau_mi);
        
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