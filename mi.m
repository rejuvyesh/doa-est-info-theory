function [lag, I] = mi(sig1, sig2, order, base)
% Estimate lag via Mutual Information criterion
% sig1: signal1
% sig2: signal2
% order: N order
% base: log base    
    
    start = 1;
    finish = length(sig1) - order;

    % construct bigger covariance matrix
    cov(1:2*order, 1:2*order) = 0;
    for i=start:finish
        sig12(1:order) = sig1(i:i+order-1);
        sig12(order+1:2*order) = sig2(i:i+order-1);
        cov = cov + sig12'*sig12;
    end

    % compute mutual information
    I = -0.5*log(det(cov)/det(cov(1:order,1:order))/det(cov(order+1:2*order, ...
                                                      order+1:2*order)))

    [_, lag] = max(I);

    % base transformation
    I = I/log(base);
end
