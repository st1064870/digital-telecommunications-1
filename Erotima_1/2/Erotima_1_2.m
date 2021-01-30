%Prepare source A
prob_A = [0.072 0.015 0.028 0.040 0.12 0.022 0.02 0.061 0.07 0.001 0.008 0.04 0.024 0.067 0.075 0.019 0.01 0.06 0.063 0.091 0.028 0.01 0.024 0.002 0.02 0.01];
range_A = 97:122;
alphabet_A = cellstr(char(range_A'));

A_num = randsrc(1, 10000, [range_A; prob_A]);
A_str = cellstr(char(A_num)');

entropy_A = -sum(prob_A .* log(prob_A))

%Prepare source B
pkwords = fopen('pkwords.txt');
B_str = num2cell(fscanf(pkwords,'%s',1));

%Using built-in function
[dict, avglen] = huffmandict(alphabet_A, prob_A);
avglen

code_A = huffmanenco(A_str, dict);
deco_A = huffmandeco(code_A, dict);

code_B = huffmanenco(B_str, dict);
deco_B = huffmandeco(code_B, dict);

%Using custom function
[dict1, avglen1] = huffmandict1(alphabet_A, prob_A);
avglen1

code1_A = huffmanenco1(A_str, dict1);
deco1_A = huffmandeco1(code1_A, dict1);

code1_B = huffmanenco1(B_str, dict1);
deco1_B = huffmandeco1(code1_B, dict1);