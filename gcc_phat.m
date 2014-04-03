for i = 1:3
    tau(i) = gcc_phat(x{i}(1,:), x{i}(2,:))
end

function tau = gcc_phat(sig1, sig2)
% Find FFT for the signals
% 
%
% Author: Jayesh Kumar Gupta, 2014.
%
% Contact: Jayesh Kumar Gupta http://rejuvyesh.com
%          Indian Institute of Technology, Kanpur, India
    
    
    fft1  = fft(sig1, fftSize(sig1));
    fft2  = fft(sig2, fftSize(sig2));
    % Find R(\Tau)
    G12   = fft1.*conj(fft2);
    denom = abs(G12);
    R     = G12./denom;

    % Maximize R ?
    r     = ifft(R);
    d1    = real(r);
    d2    = max(abs(r));
    tau   = find(abs(r)==d2);
end

function fftsz = fftSize(sig)
% Find 2^x such that 2^x>2*nSamples
    nSamples = length(sig)
    fftsz = 2;
    while fftsz < 2*nSamples
        fftsz = fftsz*2;
    end
end
