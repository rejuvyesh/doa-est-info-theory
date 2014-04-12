function [tau, phatcorr] = gcc_phat(sig1, sig2)
% Find FFT for the signals
% 
%
% Author: Jayesh Kumar Gupta, 2014.
%
% Contact: Jayesh Kumar Gupta http://rejuvyesh.com
%          Indian Institute of Technology, Kanpur, India

    cross = xcorr(sig1, sig2);
    len   = length(sig1);
    p     = 1;
    for m = 1:len
        if 2.^m<(len*2);
            p=p+1;
        end
    end
    assumesignallength = 2.^p;
    G_matrix = zeros((assumesignallength*2-1),1); % in correlation we get 2N-1(N
                                                  % being the largest of two
                                                  % sequence) length but in
                                                  % GCC-phat we get signal of
                                                  % legth of FFTlength. so making
                                                  % it to that length
    phatfilter    = zeros((assumesignallength*2-1),1);
    % cross power spectral density = X1(f)X2^*(f)
    crossspectrum = fft(cross);

    % Find the matrix G
    for k = 1:length(crossspectrum)
        phatfilter(k) = abs(crossspectrum(k));
        G_matrix(k)   = crossspectrum(k)/phatfilter(k);
    end

    % Run inverse fourier transform to find R(\tau)
    phatcorrelation = ifft(G_matrix);

    % Find absolute values
    for n = 1:length(crossspectrum)
        phatcorr(n) = abs(phatcorrelation(n));
    end

    % Find the value of tau for which it is maximum
    [phatmaximum,phattime] = max(phatcorr);
    % Because ifft returns result in wrong order
    tau = abs(assumesignallength - abs(phattime));
end