L_b=randsrc(24^3, 1, [0 1]);

% BINARY (UNIPOLAR) ENCODING

M = [2 4 8 16];
SNR = 0:5:40;
SNR = [10]
[X, Y] = meshgrid(M, SNR);
Z = zeros(size(X));

for i=1:size(Z,1)
    for j=1:size(Z,2)
        [~, BER, ~] = M_PAM(L_b, X(i,j), Y(i,j), 'bin', 1);
        Z(i,j)=BER;
    end
end

figure;
s = mesh(X,Y,Z);
title('BER for M-PAM with binary encoding');
s.FaceColor = 'flat';
xlabel('M(bits)');
ylabel('SNR(dB)');
zlabel('BER');

% GRAY ENCODING

M = [4 8 16];
SNR = 0:5:40;

[X, Y] = meshgrid(M, SNR);
Z = zeros(size(X));

for i=1:size(Z,1)
    for j=1:size(Z,2)
        %[~, BER, ~] = M_PAM1(L_b, X(i,j), Y(i,j), 'gray');
        [~, BER, ~] = M_PAM(L_b, X(i,j), Y(i,j), 'gray', 0);
        Z(i,j)=BER;
    end
end

figure;
s = mesh(X,Y,Z);
title('BER for M-PAM with gray encoding');
s.FaceColor = 'flat';
xlabel('M(bits)');
ylabel('SNR(dB)');
zlabel('BER');