function [lag, I] = mi(sig1, sig2, shift, order, base)
% Estimate lag via Mutual Information criterion
% sig1: signal1
% sig2: signal2
% shift: range of expcted tau
% order: N order
% base: log base

    start = 1+shift;
    finish = length(sig1) - shift - order + 1;

    % construct bigger covariance matrix
    cov(1:2*order+2*shift, 1:2*order+2*shift) = 0;
    for i=start:finish
        sig12(1:order) = sig1(i:i+order-1);
        sig12(order+1:2*order+2*shift) = sig2(i-shift:i+order-1+shift);
        cov = cov + sig12'*sig12;
    end

    % compute mutual information
    for i = -shift:shift
        j=order+shift+i;
        sub(1      :order  ,1      :order  )=cov(1  :order  ,1  :order  );
        sub(order+1:2*order,order+1:2*order)=cov(j+1:j+order,j+1:j+order);
        sub(1      :order  ,order+1:2*order)=cov(1  :order  ,j+1:j+order);
        sub(order+1:2*order,1      :order  )=cov(j+1:j+order,1  :order  );

        I(shift+i+1) = -0.5*log(det(sub)/det(sub(1:order,1:order))/det(sub(order+1:2*order, ...
                                                      order+1:2*order)));
    end 
    [~, lag] = max(I);
    lag      = abs(lag-shift-1);
    % base transformation
    I = I/log(base);
end

