function out = P2_109550194(op, poly1, poly2) % main function
%     poly1 = [3 1; 2 5; 0 -2];
%     poly2 = [100 2; 10 3; 3 -1];
%     X = 1:100;
%     op = 'subtract';
    validStrings = {'add', 'subtract', 'multiply', 'eval', 'plot'};
    inputOp = validatestring(op, validStrings);
    switch inputOp % switch to individual functions
        case 'add'
            out = poly_add(poly1, poly2);
        case 'subtract'
            out = poly_subtract(poly1, poly2);
        case 'multiply'
            out = poly_multiply(poly1, poly2);
        case 'eval'
            out = poly_eval(poly1, poly2);
        case 'plot'
            out = poly_plot(poly1, poly2);
    end 
end

% add
function polyOut = poly_add(poly1, poly2)
    validateattributes(poly1, {'numeric'}, {'ncols', 2}, '', 'poly1', 1);
    validateattributes(poly2, {'numeric'}, {'ncols', 2}, '', 'poly2', 2);
    polyOut = zeros(1, 2); % default [0 0]
    polyIndex = 1; % polyOut index
    i1 = 1;
    i2 = 1;
    column1 = poly1(:, 1);
    column2 = poly2(:, 1);
    max1 = length(column1);
    max2 = length(column2);
    % comparing 2 elements from 2 polynomials
    while i1 <= max1 || i2 <= max2 % while still in range
        if i1 > max1 % if finished poly1, add poly2
		    polyOut(polyIndex, 1) = column2(i2);
		    polyOut(polyIndex, 2) = poly2(i2, 2);
		    i2 = i2 + 1;
        elseif i2 > max2 % if finished poly2, add poly1
		    polyOut(polyIndex, 1) = column1(i1);
		    polyOut(polyIndex, 2) = poly1(i1, 2);
		    i1 = i1 + 1;
        elseif column1(i1) > column2(i2) % if degree from poly1 larger, add to polyOut
		    polyOut(polyIndex, 1) = column1(i1);
		    polyOut(polyIndex, 2) = poly1(i1, 2);
		    i1 = i1 + 1;
        elseif column1(i1) < column2(i2) % if degree from poly2 larger, add to polyOut
		    polyOut(polyIndex, 1) = column2(i2);
		    polyOut(polyIndex, 2) = poly2(i2, 2);
		    i2 = i2 + 1;
	    else
		    temp = poly1(i1, 2) + poly2(i2, 2); % if same degree, add coefficients
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
end

% subtract
function polyOut = poly_subtract(poly1, poly2)
    validateattributes(poly1, {'numeric'}, {'ncols', 2}, '', 'poly1', 1);
    validateattributes(poly2, {'numeric'}, {'ncols', 2}, '', 'poly2', 2);
    polyOut = zeros(1, 2); % default [0 0]
    poly2(:, 2) = poly2(:,2) * -1; % addition of complement
    polyIndex = 1; % polyOut index
    i1 = 1;
    i2 = 1;
    column1 = poly1(:, 1);
    column2 = poly2(:, 1);
    max1 = length(column1);
    max2 = length(column2);
    % comparing 2 elements from 2 polynomials
    while i1 <= max1 || i2 <= max2 % while still in range
        if i1 > max1 % if finished poly1, add poly2
		    polyOut(polyIndex, 1) = column2(i2);
		    polyOut(polyIndex, 2) = poly2(i2, 2);
		    i2 = i2 + 1;
        elseif i2 > max2 % if finished poly2, add poly1
		    polyOut(polyIndex, 1) = column1(i1);
		    polyOut(polyIndex, 2) = poly1(i1, 2);
		    i1 = i1 + 1;
        elseif column1(i1) > column2(i2) % if degree from poly1 larger, add to polyOut
		    polyOut(polyIndex, 1) = column1(i1);
		    polyOut(polyIndex, 2) = poly1(i1, 2);
		    i1 = i1 + 1;
        elseif column1(i1) < column2(i2) % if degree from poly2 larger, add to polyOut
		    polyOut(polyIndex, 1) = column2(i2);
		    polyOut(polyIndex, 2) = poly2(i2, 2);
		    i2 = i2 + 1;
	    else
		    temp = poly1(i1, 2) + poly2(i2, 2); % if same degree, add coefficients
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
	    polyIndex = polyIndex + 1; % next polyOut index
    end
end

% multiply
function polyOut = poly_multiply(poly1, poly2)
    validateattributes(poly1, {'numeric'}, {'ncols', 2}, '', 'poly1', 1);
    validateattributes(poly2, {'numeric'}, {'ncols', 2}, '', 'poly2', 2);
    polyOut = zeros(1, 2); % default [0 0]
    polyIndex = 1;
    column1 = poly1(:, 1);
    column2 = poly2(:, 1);
    max1 = length(column1);
    max2 = length(column2);
    for i = 1:max1
        for j = 1:max2
            degree = column1(i) + column2(j); % add degree
            coef = poly1(i, 2) * poly2(j, 2); % multiply coef
            if coef == 0 % if coef is 0, omit
                continue
            end
            index = find(polyOut(:, 1)==degree); % find if degree exist in polyOut
            if isempty(index) % degree not exist in polyOut
                % add into polyOut
                polyOut(polyIndex, 1) = degree;
                polyOut(polyIndex, 2) = coef;
                polyIndex = polyIndex + 1;
            else % else add into existing degree
                polyOut(index, 2) = polyOut(index, 2) + coef;
            end
        end
    end
end

% eval
function Y = poly_eval(poly1, X)
    validateattributes(poly1, {'numeric'}, {'ncols', 2}, '', 'poly1', 1);
    validateattributes(X, {'numeric'}, {'vector'}, '', 'X', 2);
    for i = 1:length(X)
        Y(i) = 0; % initialize Y(i)
        for j = 1:length(poly1) % evaluate for each degree
            Y(i) = Y(i) + poly1(j, 2) * (X(i) ^ poly1(j)); % add into Y(i)
        end
    end
end

% plot
function Y = poly_plot(poly1, X)
    validateattributes(poly1, {'numeric'}, {'ncols', 2}, '', 'poly1', 1);
    validateattributes(X, {'numeric'}, {'vector'}, '', 'X', 2);
    X = sort(X); % X needs to be sorted
    Y = poly_eval(poly1, X);
    plot(X, Y);
end