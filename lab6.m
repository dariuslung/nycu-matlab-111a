my_word_count('materials\lab6_input.txt');


function [word, count] = my_word_count(fn)
    fid = fopen(fn);
    s = textscan(fid, '%s' ,'delimiter', '., ');
    fclose(fid);
    A = lower(s{1});
    word = unique(A);
    for i = 1:length(word)
        temp = strcmp(word(i), A);
        count(i) = sum(temp);
    end
    [count, indices] = sort(count, 'descend');
    wordSorted(1:length(count)) = word(indices);
    word = wordSorted;
    if nargout == 0
        for i = 1:length(word)
            fprintf('%s\t%d\n', word{i}, count(i));
        end
    end
end