function [xq, centers, D, Kmax, intervals] = Lloyd_Max(x, N, min_value, max_value)
    %Constants
    THRESHOLD = 1e-10;

    %Initialize
    L = 2^N;
    delta = (max_value-min_value)/L;
    Kmax = 0;
    D = [];
    
    %Calculate centers and intervals
    intervals = min_value:delta:max_value;
    centers = min_value+delta/2:delta:max_value-delta/2;
    
    for i = 1:length(x)
        if x(i) >= max_value
            x(i) = max_value;
        elseif x(i) <= min_value
            x(i) = min_value;
        end
    end
    
    while 1
        close
        histogram(x, intervals);
        
        Kmax = Kmax + 1;
        intervals_prev = intervals;
        
        x_bins = discretize(x, intervals);
        for level = 1:L-1
            x_level = x(x_bins == level);
            
            if (isempty(x_level))
                continue
            end
            
            [counts, x_level_values] = groupcounts(x_level);
            pdf_x_level = counts ./ numel(x); %TODO ./ numel(x) or ./numel(x1)

            centers(level) = (x_level_values' * pdf_x_level) / sum(pdf_x_level);
        end
        
        for level = 1:L-1
            intervals(level + 1) = (centers(level) + centers(level + 1)) / 2;
        end
        
        d = mean((intervals-intervals_prev).^2);
        D(Kmax) = d;
        if Kmax >= 2
            if abs(D(Kmax) - D(Kmax-1)) <= THRESHOLD
                break;
            end
        end
    end
    
    %Quantize
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