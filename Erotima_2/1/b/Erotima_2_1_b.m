%Source A
M = 10000;
t = (randn(M,1) + 1j*randn(M,1)) / sqrt(2);
x = abs(t) .^ 2;

min_value = 0;
max_value = 4;

percent = sum(x>max_value)/length(x)