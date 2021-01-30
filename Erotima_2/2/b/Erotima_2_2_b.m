%Source B
[y, fs] = audioread('speech.wav');
%sound(y,fs);

min_value = -1;
max_value = 1;
N = [2 4 6];

sqnr = zeros(1, length(N));
kmax = zeros(1, length(N));

for j = 1:length(N)
    [yq, centers, D, Kmax] = Lloyd_Max(y, N(j), min_value, max_value);
    SQNR = 10*log10(mean(y.^2)/mean((y-yq).^2));
    sqnr(j) = SQNR;
    kmax(j) = Kmax;
end

sqnr1 = zeros(1, length(N));
kmax1 = zeros(1, length(N));

for j = 1:length(N)
    [yq, centers] = my_quantizer(y, N(j), min_value, max_value);
    SQNR = 10 * log10(mean(y.^2)/mean((y-yq).^2));
    sqnr1(j) = SQNR;
end

figure;
plot(kmax, sqnr);
hold on;
line(kmax, sqnr1, 'Color', 'red');

legend('Lloyd-Max quantizer', 'Uniform quantizer')

xlabel('Max iterations');
ylabel('SQNR');