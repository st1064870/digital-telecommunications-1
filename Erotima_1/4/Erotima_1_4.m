%Prepare source A
prob_A = [0.072 0.015 0.028 0.040 0.12 0.022 0.02 0.061 0.07 0.001 0.008 0.04 0.024 0.067 0.075 0.019 0.01 0.06 0.063 0.091 0.028 0.01 0.024 0.002 0.02 0.01];
range_A = 97:122;
alphabet_A = cellstr(char(range_A'));

%Prepare source AA
prob_AA = kron(prob_A, prob_A);

alphabet_AA = {};
for i = alphabet_A'
    for j = alphabet_A'
        alphabet_AA{end+1} = {strcat(i{1}, j{1})};
    end
end

AA_num = randsrc(2, 5000, [range_A; prob_A]);
AA_str = cellstr(char(AA_num)');

entropy_A = -sum(prob_A .* log2(prob_A))
entropy_AA = -sum(prob_AA .* log2(prob_AA))

%Encode source AA
[dict1, avglen1] = huffmandict1(alphabet_AA, prob_AA);
avglen1

code1_AA = huffmanenco1(AA_str, dict1);
deco1_AA = huffmandeco1(code1_AA, dict1);