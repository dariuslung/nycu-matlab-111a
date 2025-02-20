x = 3:100;
y = sin(.05*x + .002*x.^2) .* (1 - x.*x/20000);

% Compare
largerRight = y(1:end-1) > y(2:end); % y(x) > y(x+1)
largerLeft = y(2:end) > y(1:end-1); % y(x+1) > y(x)
smallerRight = ~largerRight; % y(x) < y(x+1)
smallerLeft = ~largerLeft; % y(x+1) < y(x)

% Fill end-points with 0
smallerRight = [smallerRight 0];
smallerLeft = [0 smallerLeft];
largerRight = [largerRight 0];
largerLeft = [0 largerLeft];

% When both requirements met
localMax = largerRight & largerLeft;
localMin = smallerRight & smallerLeft;
localMaxIndices = find(localMax);
localMinIndices = find(localMin);
xMax = x(localMaxIndices);
xMin = x(localMinIndices);
yMax = y(localMaxIndices);
yMin = y(localMinIndices);

% Plot
plot(x, y, 'b');
hold on;
scatter(x, y, 10, 'b', 'filled');
scatter(xMax, yMax, 100, 'r', 'square', 'LineWidth', 0.8);
scatter(xMin, yMin, 100, 'r', 'square', 'LineWidth', 0.8);

% Print
fprintf('Local maximums:\n');
fprintf('(%d, %.2f)\n', [xMax; yMax]);
fprintf('Local minimums:\n');
fprintf('(%d, %.2f)\n', [xMin; yMin]);
fprintf('Monotonically increasing segments:\n');
fprintf('%d - %d\n', x(1), xMax(1)); % end-point
fprintf('%d - %d\n', [xMin(1:end-1); xMax(2:end)])
fprintf('%d - %d\n', xMin(end), x(end)); % end-point
fprintf('Monotonically decreasing segments:\n');
fprintf('%d - %d\n', [xMax(1:end); xMin(1:end)]);