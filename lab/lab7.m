my_word_count('materials\lab6_input.txt', 'word+');

% word+ word- len+ len- count+ count-
function A = my_word_count(fn, sort_mode)
    fid = fopen(fn);
    s = textscan(fid, '%s' ,'delimiter', '., ');
    fclose(fid);
    B = lower(s{1});
    word = unique(B);
    for i = 1:length(word)
        temp = strcmp(word(i), B);
        %count(i) = sum(temp);
        A(i).word = word(i);
        A(i).len = strlength(word(i));
        A(i).count = sum(temp);
    end
    switch sort_mode
        case 'word+'
            temp = [A.word];
            [temp, indices] = sort(temp);
            tempSorted(1:length(temp)) = A(indices);
            A = tempSorted;
        case 'word-'
            temp = [A.word];
            [temp, indices] = sort(temp);
            tempSorted(1:length(temp)) = A(indices);
            A = flip(tempSorted);
        case 'len+'
            temp = [A.len];
            [temp, indices] = sort(temp);
            tempSorted(1:length(temp)) = A(indices);
            A = tempSorted;
        case 'len-'
            temp = [A.len];
            [temp, indices] = sort(temp);
            tempSorted(1:length(temp)) = A(indices);
            A = flip(tempSorted);
        case 'count+'
            temp = [A.count];
            [temp, indices] = sort(temp);
            tempSorted(1:length(temp)) = A(indices);
            A = tempSorted;
        case 'count-'
            temp = [A.count];
            [temp, indices] = sort(temp);
            tempSorted(1:length(temp)) = A(indices);
            A = flip(tempSorted);
    end
    % print if no argout
    if nargout == 0
        fprintf('word\tlen\tcount\n');
        for i = 1:length(A)
            fprintf('%s\t%d\t%d\n', string(A(i).word), A(i).len, A(i).count);
        end
    end
end