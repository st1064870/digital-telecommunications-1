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

%Prepare source B
pkwords = fopen('pkwords.txt');
B_str = num2cell(fscanf(pkwords,'%s',1));
alphabet_B=unique(B_str, 'stable')';

total=sum(ismember(B_str,alphabet_B));
for k=1:numel(alphabet_B)
  prob_B(k)=sum(ismember(B_str,alphabet_B(k)))/total;
end

%Prepare source BB
prob_BB = kron(prob_B, prob_B);

alphabet_BB = {};
for i = alphabet_B'
    for j = alphabet_B'
        alphabet_BB{end+1} = {strcat(i{1}, j{1})};
    end
end

BB_str = cellstr(cell2mat(reshape(B_str,2,[])'));
entropy_BB = -sum(prob_BB .* log2(prob_BB))

%Encode source BB
[dict, avglen] = huffmandict1(alphabet_BB, prob_BB);
avglen

code1_B = huffmanenco1(BB_str, dict);
deco1_B = huffmandeco1(code1_B, dict);

[dict, avglen1] = huffmandict1(alphabet_AA, prob_AA);
avglen1

code1_B = huffmanenco1(BB_str, dict);
deco1_B = huffmandeco1(code1_B, dict);