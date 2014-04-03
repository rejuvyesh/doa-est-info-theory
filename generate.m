function [sig1 sig2] = generate(c, fs, source, receiver, L, beta, speech, snr)
% Generate required signal
% c        : Sound speed    
% fs       : Sampling freq
% source   : Source positions [x y z]    
% receiver : Receiver positions [x y z]    
% L        : Room dimensions
% beta     : T60 - Reverberation time
% snr      : noise to be addded (dB)    
% 
%
% Author: Jayesh Kumar Gupta, 2014.
%
% Contact: Jayesh Kumar Gupta http://rejuvyesh.com
%          Indian Institute of Technology, Kanpur, India
    
    
    h = rir_generator(c, fs, receiver, source, L, beta);
    for j = 1:2
        x(j,:) = conv(h(j,:), speech);
    end
    for j = 1:2
        x(j,:) = awgn(x(j,:), snr);
    end 
    sig1 = x(1,:);
    sig2 = x(2,:);
end
