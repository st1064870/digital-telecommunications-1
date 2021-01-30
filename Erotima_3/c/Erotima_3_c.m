L_b=randsrc(24^4, 1, [0 1]);

% BINARY (UNIPOLAR) ENCODING

M = [2 4 8 16];
SNR = 0:5:40;

[X, Y] = meshgrid(M, SNR);
Z = zeros(size(X));

for i=1:size(Z,1)
    for j=1:size(Z,2)
        [~, ~, SER] = M_PAM(L_b, X(i,j), Y(i,j), 'bin', 0);
        Z(i,j)=SER;
    end
end

figure;
s = mesh(X,Y,Z);
title('SER for M-PAM with binary encoding');
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
        [~, ~, SER] = M_PAM(L_b, X(i,j), Y(i,j), 'gray', 0);
        Z(i,j)=SER;
    end
end

figure;
s = mesh(X,Y,Z);
title('SER for M-PAM with gray encoding');
s.FaceColor = 'flat';
xlabel('M(bits)');
ylabel('SNR(dB)');
zlabel('BER');