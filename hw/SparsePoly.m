% ID: 109550194
% Name: 龍偉亮
classdef SparsePoly
    properties (SetAccess=private)
        degree = 0;
        coefficient = 0;
    end
    
    methods
        function obj = SparsePoly(d, c)
            if nargin == 0 % No input, polynomial is zero
            elseif nargin == 2
                validateattributes(d, {'numeric'}, {'nonempty', 'row'}, '', 'degree', 1);
                validateattributes(c, {'numeric'}, {'nonempty', 'row'}, '', 'coefficient', 2);
                if ~all(size(d) == size(c)) % Different size error
                    error("ERROR: degree and coefficient have different sizes")
                end
                obj.degree = d;
                obj.coefficient = c;
            else
                error("ERROR: Bad input");
            end
        end
        
        % plus TO-DO
        function obj = plus(a, b)
            % both array
            if ~isscalar(a) && ~isscalar(b)
                if ~all(size(a) == size(b)) % Size checking
                    error("ERROR: Both arrays have different sizes")
                end
                obj(1, numel(a)) = SparsePoly;
                for i = 1:numel(a)
                    polyOut = zeros(1, 2); % default [0 0]
                    polyIndex = 1; % polyOut index
                    i1 = 1;
                    i2 = 1;
                    column1 = a(i).degree;
                    column2 = b(i).degree;
                    max1 = length(column1);
                    max2 = length(column2);
                    % comparing 2 elements from 2 polynomials
                    while i1 <= max1 || i2 <= max2 % while still in range
                        if i1 > max1 % if finished poly1, add poly2
		                    polyOut(polyIndex, 1) = column2(i2);
		                    polyOut(polyIndex, 2) = b(i).coefficient(i2);
		                    i2 = i2 + 1;
                        elseif i2 > max2 % if finished poly2, add poly1
		                    polyOut(polyIndex, 1) = column1(i1);
		                    polyOut(polyIndex, 2) = a(i).coefficient(i1);
		                    i1 = i1 + 1;
                        elseif column1(i1) > column2(i2) % if degree from poly1 larger, add to polyOut
		                    polyOut(polyIndex, 1) = column1(i1);
		                    polyOut(polyIndex, 2) = a(i).coefficient(i1);
		                    i1 = i1 + 1;
                        elseif column1(i1) < column2(i2) % if degree from poly2 larger, add to polyOut
		                    polyOut(polyIndex, 1) = column2(i2);
		                    polyOut(polyIndex, 2) = b(i).coefficient(i2);
		                    i2 = i2 + 1;
	                    else
		                    temp = a(i).coefficient(i1) + b(i).coefficient(i2); % if same degree, add coefficients
                            if temp == 0 % if coef is 0, omit
                                i1 = i1 + 1;
                                i2 = i2 + 1;
                                continue
                            end
		                    polyOut(polyIndex, 1) = column1(i1);
		                    polyOut(polyIndex, 2) = temp;
		                    i1 = i1 + 1;
		                    i2 = i2 + 1;
                        end
	                    polyIndex = polyIndex + 1;
                    end
                    obj(i).degree = polyOut(:, 1);
                    [~, index] = sort(obj(i).degree, 'descend');
                    obj(i).degree = obj(i).degree(index);
                    obj(i).coefficient = polyOut(index, 2);
                end
                obj = reshape(obj, size(a));
            % a scalar b array
            elseif isscalar(a) && ~isscalar(b)
                obj(1, numel(b)) = SparsePoly;
                for i = 1:numel(b)
                    polyOut = zeros(1, 2); % default [0 0]
                    polyIndex = 1; % polyOut index
                    i1 = 1;
                    i2 = 1;
                    column1 = a(1).degree;
                    column2 = b(i).degree;
                    max1 = length(column1);
                    max2 = length(column2);
                    % comparing 2 elements from 2 polynomials
                    while i1 <= max1 || i2 <= max2 % while still in range
                        if i1 > max1 % if finished poly1, add poly2
		                    polyOut(polyIndex, 1) = column2(i2);
		                    polyOut(polyIndex, 2) = b(i).coefficient(i2);
		                    i2 = i2 + 1;
                        elseif i2 > max2 % if finished poly2, add poly1
		                    polyOut(polyIndex, 1) = column1(i1);
		                    polyOut(polyIndex, 2) = a(1).coefficient(i1);
		                    i1 = i1 + 1;
                        elseif column1(i1) > column2(i2) % if degree from poly1 larger, add to polyOut
		                    polyOut(polyIndex, 1) = column1(i1);
		                    polyOut(polyIndex, 2) = a(1).coefficient(i1);
		                    i1 = i1 + 1;
                        elseif column1(i1) < column2(i2) % if degree from poly2 larger, add to polyOut
		                    polyOut(polyIndex, 1) = column2(i2);
		                    polyOut(polyIndex, 2) = b(i).coefficient(i2);
		                    i2 = i2 + 1;
	                    else
		                    temp = a(1).coefficient(i1) + b(i).coefficient(i2); % if same degree, add coefficients
                            if temp == 0 % if coef is 0, omit
                                i1 = i1 + 1;
                                i2 = i2 + 1;
                                continue
                            end
		                    polyOut(polyIndex, 1) = column1(i1);
		                    polyOut(polyIndex, 2) = temp;
		                    i1 = i1 + 1;
		                    i2 = i2 + 1;
                        end
	                    polyIndex = polyIndex + 1;
                    end
                    obj(i).degree = polyOut(:, 1);
                    [~, index] = sort(obj(i).degree, 'descend');
                    obj(i).degree = obj(i).degree(index);
                    obj(i).coefficient = polyOut(index, 2);
                end
                obj = reshape(obj, size(b));
            % a array b scalar
            elseif ~isscalar(a) && isscalar(b)
                obj(1, numel(a)) = SparsePoly;
                for i = 1:numel(a)
                    polyOut = zeros(1, 2); % default [0 0]
                    polyIndex = 1; % polyOut index
                    i1 = 1;
                    i2 = 1;
                    column1 = a(i).degree;
                    column2 = b(1).degree;
                    max1 = length(column1);
                    max2 = length(column2);
                    % comparing 2 elements from 2 polynomials
                    while i1 <= max1 || i2 <= max2 % while still in range
                        if i1 > max1 % if finished poly1, add poly2
		                    polyOut(polyIndex, 1) = column2(i2);
		                    polyOut(polyIndex, 2) = b(1).coefficient(i2);
		                    i2 = i2 + 1;
                        elseif i2 > max2 % if finished poly2, add poly1
		                    polyOut(polyIndex, 1) = column1(i1);
		                    polyOut(polyIndex, 2) = a(i).coefficient(i1);
		                    i1 = i1 + 1;
                        elseif column1(i1) > column2(i2) % if degree from poly1 larger, add to polyOut
		                    polyOut(polyIndex, 1) = column1(i1);
		                    polyOut(polyIndex, 2) = a(i).coefficient(i1);
		                    i1 = i1 + 1;
                        elseif column1(i1) < column2(i2) % if degree from poly2 larger, add to polyOut
		                    polyOut(polyIndex, 1) = column2(i2);
		                    polyOut(polyIndex, 2) = b(1).coefficient(i2);
		                    i2 = i2 + 1;
	                    else
		                    temp = a(i).coefficient(i1) + b(1).coefficient(i2); % if same degree, add coefficients
                            if temp == 0 % if coef is 0, omit
                                i1 = i1 + 1;
                                i2 = i2 + 1;
                                continue
                            end
		                    polyOut(polyIndex, 1) = column1(i1);
		                    polyOut(polyIndex, 2) = temp;
		                    i1 = i1 + 1;
		                    i2 = i2 + 1;
                        end
	                    polyIndex = polyIndex + 1;
                    end
                    obj(i).degree = polyOut(:, 1);
                    [~, index] = sort(obj(i).degree, 'descend');
                    obj(i).degree = obj(i).degree(index);
                    obj(i).coefficient = polyOut(index, 2);
                end
                obj = reshape(obj, size(a));
            % both scalar
            else
                polyOut = zeros(1, 2); % default [0 0]
                polyIndex = 1; % polyOut index
                i1 = 1;
                i2 = 1;
                column1 = a(1).degree;
                column2 = b(1).degree;
                max1 = length(column1);
                max2 = length(column2);
                % comparing 2 elements from 2 polynomials
                while i1 <= max1 || i2 <= max2 % while still in range
                    if i1 > max1 % if finished poly1, add poly2
	                    polyOut(polyIndex, 1) = column2(i2);
	                    polyOut(polyIndex, 2) = b(1).coefficient(i2);
	                    i2 = i2 + 1;
                    elseif i2 > max2 % if finished poly2, add poly1
	                    polyOut(polyIndex, 1) = column1(i1);
	                    polyOut(polyIndex, 2) = a(1).coefficient(i1);
	                    i1 = i1 + 1;
                    elseif column1(i1) > column2(i2) % if degree from poly1 larger, add to polyOut
	                    polyOut(polyIndex, 1) = column1(i1);
	                    polyOut(polyIndex, 2) = a(1).coefficient(i1);
	                    i1 = i1 + 1;
                    elseif column1(i1) < column2(i2) % if degree from poly2 larger, add to polyOut
	                    polyOut(polyIndex, 1) = column2(i2);
	                    polyOut(polyIndex, 2) = b(1).coefficient(i2);
	                    i2 = i2 + 1;
                    else
	                    temp = a(1).coefficient(i1) + b(1).coefficient(i2); % if same degree, add coefficients
                        if temp == 0 % if coef is 0, omit
                            i1 = i1 + 1;
                            i2 = i2 + 1;
                            continue
                        end
	                    polyOut(polyIndex, 1) = column1(i1);
	                    polyOut(polyIndex, 2) = temp;
	                    i1 = i1 + 1;
	                    i2 = i2 + 1;
                    end
                    polyIndex = polyIndex + 1;
                end
                obj.degree = polyOut(:, 1);
                [~, index] = sort(obj.degree, 'descend');
                obj.degree = obj.degree(index);
                obj.coefficient = polyOut(index, 2);
            end
        end

        % minus
        function obj = minus(a, b)
            % complement of b
            for i = 1:numel(b)
                b(i).coefficient = b(i).coefficient * -1;
            end
            obj = a + b;
        end

        % times
        function obj = times(a, b)
            if ~isscalar(a) && ~isscalar(b)
                if ~all(size(a) == size(b)) % Size checking
                    error("ERROR: Both arrays have different sizes")
                end
                obj(1, numel(a)) = SparsePoly;
                for k = 1:numel(a)
                    polyOut = zeros(1, 2); % default [0 0]
                    polyIndex = 1;
                    column1 = a(k).degree;
                    column2 = b(k).degree;
                    max1 = length(column1);
                    max2 = length(column2);
                    for i = 1:max1
                        for j = 1:max2
                            tempDegree = column1(i) + column2(j); % add degree
                            coef = a(k).coefficient(i) * b(k).coefficient(j); % multiply coef
                            if coef == 0 % if coef is 0, omit
                                continue
                            end
                            index = find(polyOut(:, 1)==tempDegree); % find if degree exist in polyOut
                            if isempty(index) % degree not exist in polyOut
                                % add into polyOut
                                polyOut(polyIndex, 1) = tempDegree;
                                polyOut(polyIndex, 2) = coef;
                                polyIndex = polyIndex + 1;
                            else % else add into existing degree
                                polyOut(index, 2) = polyOut(index, 2) + coef;
                            end
                        end
                    end
                    obj(k).degree = polyOut(:, 1);
                    [~, index] = sort(obj(k).degree, 'descend');
                    obj(k).degree = obj(k).degree(index);
                    obj(k).coefficient = polyOut(index, 2);
                end
                obj = reshape(obj, size(a));
            % a scalar b array
            elseif isscalar(a) && ~isscalar(b)
                obj(1, numel(b)) = SparsePoly;
                for k = 1:numel(b)
                    polyOut = zeros(1, 2); % default [0 0]
                    polyIndex = 1;
                    column1 = a(1).degree;
                    column2 = b(k).degree;
                    max1 = length(column1);
                    max2 = length(column2);
                    for i = 1:max1
                        for j = 1:max2
                            tempDegree = column1(i) + column2(j); % add degree
                            coef = a(1).coefficient(i) * b(k).coefficient(j); % multiply coef
                            if coef == 0 % if coef is 0, omit
                                continue
                            end
                            index = find(polyOut(:, 1)==tempDegree); % find if degree exist in polyOut
                            if isempty(index) % degree not exist in polyOut
                                % add into polyOut
                                polyOut(polyIndex, 1) = tempDegree;
                                polyOut(polyIndex, 2) = coef;
                                polyIndex = polyIndex + 1;
                            else % else add into existing degree
                                polyOut(index, 2) = polyOut(index, 2) + coef;
                            end
                        end
                    end
                    obj(k).degree = polyOut(:, 1);
                    [~, index] = sort(obj(k).degree, 'descend');
                    obj(k).degree = obj(k).degree(index);
                    obj(k).coefficient = polyOut(index, 2);
                end
                obj = reshape(obj, size(b));
            % a array b scalar
            elseif ~isscalar(a) && isscalar(b)
                obj(1, numel(a)) = SparsePoly;
                for k = 1:numel(a)
                    polyOut = zeros(1, 2); % default [0 0]
                    polyIndex = 1;
                    column1 = a(k).degree;
                    column2 = b(1).degree;
                    max1 = length(column1);
                    max2 = length(column2);
                    for i = 1:max1
                        for j = 1:max2
                            tempDegree = column1(i) + column2(j); % add degree
                            coef = a(k).coefficient(i) * b(1).coefficient(j); % multiply coef
                            if coef == 0 % if coef is 0, omit
                                continue
                            end
                            index = find(polyOut(:, 1)==tempDegree); % find if degree exist in polyOut
                            if isempty(index) % degree not exist in polyOut
                                % add into polyOut
                                polyOut(polyIndex, 1) = tempDegree;
                                polyOut(polyIndex, 2) = coef;
                                polyIndex = polyIndex + 1;
                            else % else add into existing degree
                                polyOut(index, 2) = polyOut(index, 2) + coef;
                            end
                        end
                    end
                    obj(k).degree = polyOut(:, 1);
                    [~, index] = sort(obj(k).degree, 'descend');
                    obj(k).degree = obj(k).degree(index);
                    obj(k).coefficient = polyOut(index, 2);
                end
                obj = reshape(obj, size(a));
            % both scalar
            else
                polyOut = zeros(1, 2); % default [0 0]
                polyIndex = 1;
                column1 = a(1).degree;
                column2 = b(1).degree;
                max1 = length(column1);
                max2 = length(column2);
                for i = 1:max1
                    for j = 1:max2
                        tempDegree = column1(i) + column2(j); % add degree
                        coef = a(1).coefficient(i) * b(1).coefficient(j); % multiply coef
                        if coef == 0 % if coef is 0, omit
                            continue
                        end
                        index = find(polyOut(:, 1)==tempDegree); % find if degree exist in polyOut
                        if isempty(index) % degree not exist in polyOut
                            % add into polyOut
                            polyOut(polyIndex, 1) = tempDegree;
                            polyOut(polyIndex, 2) = coef;
                            polyIndex = polyIndex + 1;
                        else % else add into existing degree
                            polyOut(index, 2) = polyOut(index, 2) + coef;
                        end
                    end
                end
                obj.degree = polyOut(:, 1);
                [~, index] = sort(obj.degree, 'descend');
                obj.degree = obj.degree(index);
                obj.coefficient = polyOut(index, 2);
            end
        end

        % eval
        function out = eval(a, X)
            for k = 1:numel(a)
                out(k).Y(1:length(X)) = 0; % initialize Y(k)
                for i = 1:length(X)
                    for j = 1:length(a(k).degree) % evaluate for each degree
                        out(k).Y(i) = out(k).Y(i) + a(k).coefficient(j) * (X(i) ^ a(k).degree(j)); % add into out(k).Y(i)
                    end
                end
            end
            out = reshape(out, size(a));
        end

        % plot
        function out = plot(a, X)
            X = sort(X); % X needs to be sorted
            out = a.eval(X);
            for k = 1:numel(out)
                plot(X, out(k).Y);
                hold on;
            end
            hold off;
        end

        % disp
        function disp(a)
            if isscalar(a)
                if a.coefficient(1) == 1
                    fprintf("x^%d", a.degree(1));
                elseif a.coefficient(1) == -1
                    fprintf("-x^%d", a.degree(1));
                else
                    fprintf("%dx^%d", a.coefficient(1), a.degree(1));
                end
                if length(a.degree) > 1
                    for i = 2:length(a.degree)
                        if a.coefficient(i) == 1
                            fprintf("+x^%d", a.degree(i));
                        elseif a.coefficient(i) == -1
                            fprintf("-x^%d", a.degree(i));
                        else
                            fprintf("%+dx^%d", a.coefficient(i), a.degree(i));
                        end
                    end
                end
                fprintf("\n");
            else
                fprintf("SparsePoly array (size %dx%d)\n", size(a, 1), size(a, 2));
            end
        end
    end
end

