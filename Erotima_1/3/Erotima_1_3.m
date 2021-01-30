%Prepare source B
pkwords = fopen('pkwords.txt');
B_str = num2cell(fscanf(pkwords,'%s',1));
alphabet_B=unique(B_str, 'stable');

total=sum(ismember(B_str,alphabet_B));
for k=1:numel(alphabet_B)
  prob_B(k)=sum(ismember(B_str,alphabet_B(k)))/total;
end

entropy_B = -sum(prob_B .* log2(prob_B))

%Encode source B
[dict, avglen] = huffmandict1(alphabet_B, prob_B);
avglen

code1_B = huffmanenco1(B_str, dict);
deco1_B = huffmandeco1(code1_B, dict);