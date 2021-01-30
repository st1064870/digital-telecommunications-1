function theoretical_probs = quantizations_theoretical_probs(intervals, pd)
    intervals(1) = -Inf;
    intervals(end) = +Inf;
    cdf1 = cdf(pd, intervals);
    
    for i = 1:length(intervals)-1
        theoretical_probs(i) = cdf1(i+1) - cdf1(i);
    end
end

