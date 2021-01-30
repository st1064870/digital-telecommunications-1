function code = huffmanenco1(sig, dict)
    code = [];
    for i = 1:length(sig)
        for j = 1:length(dict)
            if (strcmp(sig(i), dict{j,1}))
                code = [code dict{j,2}];
            end
        end
    end
end