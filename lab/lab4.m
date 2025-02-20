n=100; [x,y]=meshgrid(-n:2:n,-n:2:n); % the grid points
z1=sin((x-.002*x.*x)/n*5).^2+1;
z2=sin((x+2*y)/n*2).^2+.5;
t1=80; w1=t1*t1./((x-20).^2+(y-40).^2+t1*t1);
z=z1.*z2.*w1*1000+rand(size(z1))*.1; % values of the grid points

% orthogonal
vertz = zeros(n+1, 1);
horzz = zeros(1, n+1);
up = z(:, 2:end) > z(:, 1:end-1);
up = horzcat(vertz, up);
down = z(:, 1:end-1) > z(:, 2:end);
down = horzcat(down, vertz);
left = z(2:end, :) > z(1:end-1, :);
left = vertcat(horzz, left);
right = z(1:end-1, :) > z(2:end, :);
right = vertcat(right, horzz);

% diagonal
upleft = z(2:end, 2:end) > z(1:end-1, 1:end-1);
upleft = horzcat(vertz, vertcat(horzz(1:n), upleft));
downright = z(1:end-1, 1:end-1) > z(2:end, 2:end);
downright = horzcat(vertcat(downright, horzz(1:n)), vertz);
upright = z(1:end-1, 2:end) > z(2:end, 1:end-1);
upright = horzcat(vertz, vertcat(upright, horzz(1:n)));
downleft = z(2:end, 1:end-1) > z(1:end-1, 2:end);
downleft = horzcat(vertcat(horzz(1:n), downleft), vertz);

% map
localmax = up & down & left & right & upleft & downright & upright & downleft;
indices = find(localmax);

% plot
subplot(1, 2, 1);
contourf(x, y, z);
text(x(indices), y(indices), num2str(round(z(indices))))

subplot(1, 2, 2);
mesh(x, y, z);
text(x(indices), y(indices), z(indices), num2str(round(z(indices))))