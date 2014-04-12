function [sig1, sig2] = generate(h, speech, snr)
% Generate required signal
%
% h      : impulse response of the room
% speech : the input signal `x` to be convoluted with the impulse response
% snr    : noise (dB) to be added
%
% Authors: Jayesh Kumar Gupta, Arpit Jangid, 2014.
%
% Contact: Jayesh Kumar Gupta http://rejuvyesh.com
%          Indian Institute of Technology, Kanpur, India
    
    for j = 1:2
        x(j,:) = conv(h(j,:), speech);
    end
    for j = 1:2
        x(j,:) = awgn(x(j,:), snr);
    end 
    sig1 = x(1,:);
    sig2 = x(2,:);
end
