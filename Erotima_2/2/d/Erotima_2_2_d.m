%Source B
[y, fs] = audioread('speech.wav');
%sound(y,fs);

min_value = -1;
max_value = 1;
N = [2 4 6];

mse = zeros(1, length(N));
mse1 = zeros(1, length(N));

for j = 1:length(N)
    [yq, centers, D] = Lloyd_Max(y, N(j), min_value, max_value);
    mse(j) = sum(((y - yq) .^ 2)) / length(y);
    
    [yq1, centers] = my_quantizer(y, N(j), min_value, max_value);
    mse1(j) = sum(((y - yq1) .^ 2)) / length(y);
end

figure;
plot(N, mse);
hold on;
plot(N, mse1);

xlabel('N');
ylabel('MSE');
legend('Lloyd-Max quantizer', 'Uniform quantizer');
title('Mean Square Error by N');