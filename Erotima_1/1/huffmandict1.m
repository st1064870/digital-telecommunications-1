function [dict, avglen] = huffmandict1(alphabet, prob)
    for i = 1:length( prob )
        codewords{i} = '';
        symbol{i} = i;
    end
    
    prob_old = prob;
    
    while ( prob ~= 1 )
        [~, sorted_prob_ind] = sort(prob);
        
        last = sorted_prob_ind(1);
        second_to_last = sorted_prob_ind(2);

        right_set = symbol{last};
        left_set  = symbol{second_to_last};

        right_probability = prob(last);  
        left_probability  = prob(second_to_last); 

        symbol(sorted_prob_ind(1:2)) = '';
        prob(sorted_prob_ind(1:2))   = '';
        symbol = [symbol [right_set, left_set]];
        prob   = [prob right_probability + left_probability];

        for i = 1:length(right_set)
            codewords{right_set(i)} = strcat('1',codewords{right_set(i)});
        end
        for i = 1:length(left_set)
            codewords{left_set(i)} = strcat('0',codewords{left_set(i)});
        end
    end
    
    for i=1:length(alphabet)
        dict{i,1} = alphabet{i};
        dict{i,2} = double(codewords{i}-'0');
    end
    avglen = sum(strlength(codewords).*prob_old);
end
