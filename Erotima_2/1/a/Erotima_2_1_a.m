%Source A
M = 10000;
t = (randn(M,1) + 1j*randn(M,1)) / sqrt(2);
x = abs(t) .^ 2;

min_value = 0;
max_value = 4;

N = 4;
[xq, centers] = my_quantizer(x, N, min_value, max_value);
SQNR_4 = 10 * log10(mean(x.^2)/mean((x-xq).^2))

N = 6;
[xq, centers] = my_quantizer(x, N, min_value, max_value);
SQNR_6 = 10 * log10(mean(x.^2)/mean((x-xq).^2))
