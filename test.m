str=cellstr(char(randi([33 126],1,10)'));
str=[str{:}];

printable_chars='!':'~';
total=sum(ismember(str,printable_chars));
for k=1:numel(AZ)
  prob(k)=sum(ismember(str,AZ(k)))/total;
end

alphabet = cellstr(char(33:126)');
%figure
%bar(33:126, freq');
%set(gca, 'XTickLabel', alphabet, 'XTick',33:126)

[dict, avglen] = huffmandict1(alphabet, prob);
[dict1, avglen1] = huffmandict(alphabet, prob);

code = huffmanenco(alphabet, prob);
code1 = huffmanenco(alphabet, prob);

% printable = cellstr(char(33:126)');
% 
% [bincounts] = histcounts(rand_num, 126-33+1)./10000;
% 
% figure
% bar(bincounts,'histc')
% set(gca, 'XTickLabel', printable, 'XTick',1:numel(printable))

M = 200;
t = (unifrnd(0,10,[1 100]) + unifrnd(0,10,[1 100])*1i);
figure;
plot(t,'x');
hold on;
t = randn(M,1) + 1j*randn(M,1) + (5 + 5i);
plot(t,'o');
x = abs(t) .^ 2;


[p,x] = histogram(t);
plot(x, p/sum(p));
plot
figure;
plot(t,'x');
hold on;


%line_color = ['b' 'g' 'y' 'c' 'm' 'r'];
%line_style = ['-', '--'];


% smd = zeros(length(sm), 1);
% for i = 1:length(sm)
%     ind = ((i - 1) * 40) + 1;
%     smd(i) = sum(r(ind:(ind + 39))); % \int_{0}^{T}r(t)dt TODO
% end
