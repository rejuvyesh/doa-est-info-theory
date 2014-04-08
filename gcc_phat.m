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
    gcc_phat = zeros((assumesignallength*2-1),1); % in correlation we get 2N-1(N
                                                 % being the largest of two
                                                 % sequence) length but in
                                                 % GCC-phat we get signal of
                                                 % legth of FFTlength. so making
                                                 % it to that length
    phatfilter = zeros((assumesignallength*2-1),1);
    crossspectrum = fft(cross);%=cross power spectral density=X1(f)X2^*(f)
    for k = 1:length(crossspectrum)
        phatfilter(k) = abs(crossspectrum(k));
        gcc_phat(k)   = crossspectrum(k)/phatfilter(k);
    end
    phatcorrelation = ifft(gcc_phat);
    for n = 1:length(crossspectrum)
        phatcorr(n) = abs(phatcorrelation(n));
    end
    [phatmaximum,phattime] = max(phatcorr);
    tau = abs(assumesignallength - abs(phattime));
    figure
    n1=-(length(phatcorr)-1)/2:(length(phatcorr)-1)/2;
    plot(n1,phatcorr);
end