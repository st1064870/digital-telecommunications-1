% mid-tread quantizer
function [xq, centers, intervals] = my_quantizer(x, N, min_value, max_value)  
    L = 2^N;
    delta = (max_value-min_value)/L;
    centers = min_value+delta/2:delta:max_value-delta/2;
    intervals = min_value:delta:max_value;
    
    xq = zeros(size(x));
    for i = 1:length(x)
        if x(i) >= max_value
            xq(i) = centers(end);
        elseif x(i) <= min_value
            xq(i) = centers(1);
        else
        	[~, index] = min(abs(centers - x(i)));
            xq(i) = centers(index);
        end
    end
end