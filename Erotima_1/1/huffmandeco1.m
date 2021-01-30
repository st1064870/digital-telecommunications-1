function sig = huffmandeco1(code, dict)
    i = 1;
    w = 1;
    while (i <= length(code))
        for j = 1:length(dict)
            code_check = dict{j,2};
            letter_check = dict{j,1};
            try
                a = code(i:i+length(code_check)-1);
            catch
                a = code(i:end);
            end
            if (isequal(code_check, a))
                sig{w} = letter_check;
                i = i + length(code_check);
                w = w + 1;
            end
        end
    end
end