%Source B
[y, fs] = audioread('speech.wav');
%sound(y,fs);

min_value = -1;
max_value = 1;
N = [2 4 6];

sqnr = zeros(1, length(N));
kmax = zeros(1, length(N));

for j = 1:length(N)
    [xq, centers, D, Kmax] = Lloyd_Max(y, N(j), min_value, max_value);
    SQNR = 10*log10(mean(y.^2)/mean((y-xq).^2));
    sqnr(j) = SQNR;
    kmax(j) = Kmax;
end


plot(kmax, sqnr);

xlabel('Max iterations');
ylabel('SQNR');