%Source B
[y, fs] = audioread('speech.wav');
%sound(y,fs);

pd = fitdist(y, 'tLocationScale'); %Using Normal instead of Laplace

min_value = -1;
max_value = 1;
N = [2 4 6];

sqnr1 = zeros(1, length(N));

for j = 1:length(N)
    delta = (max_value-min_value)/(2^N(j));
    edges = min_value:delta:max_value;
    
    [yq, centers, intervals] = my_quantizer(y, N(j), min_value, max_value);
    
    [counts, ~] = histcounts(yq, edges);
    probs = counts ./ sum(counts);
    entropies = - probs .* log2(probs);
    entropies(isnan(entropies)) = 0;
    
%    qqplot(y(y>0),pd);
    theoretical_probs = quantization_theoretical_probs(intervals, pd);

    figure;
    histogram('BinEdges', edges, 'BinCounts', round(theoretical_probs, 2));
    title(['Theoretical and Practical probability of quantization levels for N=', num2str(N(j))]);
    hold on;
    histogram('BinEdges', edges, 'BinCounts', round(probs, 2));
    legend('Theoretical probability','Practical probability', 'Location', 'northwest');
    
    figure;
    histogram('BinEdges', edges, 'BinCounts', round(entropies, 2));
    title(['Entropy of quantization levels for N=', num2str(N(j))])
end