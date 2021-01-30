function [out, BER, SER] = M_PAM(input, M, SNR, encoding, show_plot)

k = log2(M);
Lb = length(input);

E_s = 1;

% We have 4 samples per carrier period (Tc) and
% 10 carrier periods (Tc) per symbol period (T_sym).

% Symbol (based on target symbol ratio)
T_sym = 40;
f_sym = 1/40;

% Carrier
Tc = 4;
fc = 1/4;

% Sample
T_sample = 1;

% Constellation
constellation = zeros(M, 1);
for i = 1:M
    constellation(i) = ((2 * i) - 1 - M);
end

gt = sqrt(2 / T_sym);

% ------------------------------MAPPER-------------------------------------

blocks_in = reshape(input, [], k);
if strcmp(encoding, 'bin')
    m = bi2de(blocks_in, 'left-msb') + 1;
else
    m = bi2de(blocks_in, 'left-msb');
    m = bin2gray(m, 'pam', M) + 1;
end

sm = (2 .* m - 1 - M);

if show_plot
    tmp = repelem(sm, T_sym);
    figure('Position', [10 10 900 600])
    subplot(4,1,1);
    plot(1:T_sample:T_sample*T_sym*10, tmp(1:T_sample*T_sym*10));
    title("Subplot 1: Original signal")
end

% ----------------------------Modulation-----------------------------------

smt = zeros(length(sm) * 40, 1);
t = (0:T_sample:(T_sym - T_sample))';

for i = 1:length(sm)
    for j = 1:length(t)
        smt((i - 1) * 40 + j) = sm(i) * gt * cos(2 * pi * fc * t(j));
    end
end

if show_plot
    subplot(4,1,2);
    plot(1:T_sample:T_sample*T_sym*10, smt(1:T_sample*T_sym*10));
    title("Subplot 2: Transmitter's output");
end

% -----------------------------AWGN----------------------------------------

var = (E_s / (2 * log2(M))) * 10 ^ (- SNR / 10);
noise = sqrt(var) * randn(length(smt), 1);
r = smt + noise;

if show_plot
    subplot(4,1,3);
    plot(1:T_sample:T_sample*T_sym*10, r(1:T_sample*T_sym*10));
    title("Subplot 3: Signal with AWGN");
end

%---------------------------Demodulation-----------------------------------    
for i=1:length(r)
    r(i)=r(i)*gt*cos(2*pi*fc*(i-1)*T_sample)*T_sample;
end

if show_plot
    subplot(4,1,4);
    plot(1:T_sample:T_sample*T_sym*10, r(1:T_sample*T_sym*10));
    title("Subplot 4: Receiver's signal after filtering")
end

demodulated=zeros(size(sm));
for i=1:length(sm)
    ind=((i-1)*40)+1;
    demodulated(i)=sum(r(ind:(ind+39)));
end

%-------------------Decision----------------------------------------------- 

decision=zeros(size(sm));
for i=1:length(sm)
    dist=abs(constellation-demodulated(i));
    [~,ind]=min(dist);
    decision(i)=ind; 
end

% Calculate SER
errorsym=0;
totalsymb=0;
for i=1:length(sm)
    if decision(i)~=m(i)
        errorsym=errorsym+1;
    end
    totalsymb=totalsymb+1;
end

%---------------------------------Demapper---------------------------------  
if strcmp(encoding,'bin')
    blocks_out=de2bi(decision-1,k,'left-msb');
else
    decision=gray2bin(decision-1,'pam',M);
    blocks_out=de2bi(decision,k,'left-msb');
end

output_sequence=reshape(blocks_out,[],1);


k=input(input~=output_sequence);
BER=length(k)/length(input);
out=output_sequence;
SER=errorsym/totalsymb;
end