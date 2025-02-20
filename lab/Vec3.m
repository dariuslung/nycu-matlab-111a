classdef Vec3
    properties
        x = 0;
        y = 0;
        z = 0;
    end
    methods
        % constructor
        function obj = Vec3(x, y, z)
            if nargin == 0
            elseif nargin == 3 && all(size(x) == size(y)) && all(size(y) == size(z))
                obj(1, numel(x)) = Vec3;
                for i = 1:numel(x)
                    obj(i).x = x(i);
                    obj(i).y = y(i);
                    obj(i).z = z(i);
                end
                obj = reshape(obj, size(x));
            else
                error("Input error!");
            end
        end

        % disp
        function disp(a)
            for i = 1:size(a, 1)
                fprintf("\n")
                for j = 1:size(a, 2)
                    fprintf("(%.4f %.4f %.4f)\t", a(i, j).x, a(i, j).y, a(i, j).z);
                end
            end
        end

        % plus
        function obj = plus(a, b)
            if ~isscalar(a) && ~isscalar(b)
                if ~all(size(a) == size(b))
                    error("ERROR: Both matrices have different sizes")
                end
                obj(1, numel(a)) = Vec3;
                for i = 1:numel(a)
                    obj(i).x = a(i).x + b(i).x;
                    obj(i).y = a(i).y + b(i).y;
                    obj(i).z = a(i).z + b(i).z;
                end
                obj = reshape(obj, size(a));
            elseif isscalar(a) || isscalar(b)
                obj.x = a(1).x + b(1).x;
                obj.y = a(1).y + b(1).y;
                obj.z = a(1).z + b(1).z;
            end
        end

        % minus
        function obj = minus(a, b)
            for i = 1:numel(b)
                b(i).x = b(i).x * -1;
                b(i).y = b(i).y * -1;
                b(i).z = b(i).z * -1;
            end
            obj = a + b;
        end

        % eq
        function out = eq(a, b)
            if ~isscalar(a) && ~isscalar(b)
                if ~all(size(a) == size(b))
                    error("ERROR: Both matrices have different sizes")
                end
                out = zeros(1, numel(a));
                for i = 1:numel(a)
                    if a(i).x == b(i).x && a(i).y == b(i).y && a(i).z == b(i).z
                        out(i) = 1;
                    end
                end
                out = reshape(out, size(a));
            elseif isscalar(a) || isscalar(b)
                if a(1).x == b(1).x && a(1).y == b(1).y && a(1).z == b(1).z
                    out = 1;
                end
            end
        end

        % times
        function obj = times(a, m)
            obj(1, numel(a)) = Vec3;
            for i = 1:numel(a)
                obj(i).x = a(i).x * m;
                obj(i).y = a(i).y * m;
                obj(i).z = a(i).z * m;
            end
            obj = reshape(obj, size(a));
        end

        % inner_prod
        function out = inner_prod(a, b)
            if ~isscalar(a) && ~isscalar(b)
                if ~all(size(a) == size(b))
                    error("ERROR: Both matrices have different sizes")
                end
                out = zeros(1, numel(a));
                for i = 1:numel(a)
                    out(i) = (a(i).x * b(i).x) + (a(i).y * b(i).y) + (a(i).z * b(i).z);
                end
                out = reshape(out, size(a));
            elseif isscalar(a) || isscalar(b)
                out = (a(1).x * b(1).x) + (a(1).y * b(1).y) + (a(1).z * b(1).z);
            end
        end

        % cross_prod
        function obj = cross_prod(a,b)
            if ~isscalar(a) && ~isscalar(b)
                if ~all(size(a) == size(b))
                    error("ERROR: Both matrices have different sizes")
                end
                obj(1, numel(a)) = Vec3;
                for i = 1:numel(a)
                    obj(i).x = a(i).y * b(i).z - a(i).z * b(i).y;
                    obj(i).y = a(i).z * b(i).x - a(i).x * b(i).z;
                    obj(i).z = a(i).x * b(i).y - a(i).y * b(i).x;
                end
                obj = reshape(obj, size(a));
            elseif isscalar(a) || isscalar(b)
                obj.x = a(1).y * b(1).z - a(1).z * b(1).y;
                obj.y = a(1).z * b(1).x - a(1).x * b(1).z;
                obj.z = a(1).x * b(1).y - a(1).y * b(1).x;
            end
        end
        
        % norm
        function out = norm(a)
            out = zeros(1, numel(a));
            for i = 1:numel(a)
                out(i) = sqrt(a(i).x^2 + a(i).y^2 + a(i).z^2);
            end
            out = reshape(out, size(a));
        end

        % iszero
        function out = iszero(a)
            out = zeros(1, numel(a));
            for i = 1:numel(a)
                if (a(i).x == 0) && (a(i).y == 0) && (a(i).z == 0)
                    out(i) = 1;
                else
                    out(i) = 0;
                end
            end
            out = reshape(out, size(a));
        end
        
        % normalize
        function obj = normalize(a)
            temp = iszero(a);
            if any(temp(:) == 1)
                error("Normalization error! Some or all inputs are zero vectors")
            end
            length = norm(a);
            obj(1, numel(a)) = Vec3;
            for i = 1:numel(a)
                obj(i).x = a(i).x / length(i);
                obj(i).y = a(i).y / length(i);
                obj(i).z = a(i).z / length(i);
            end
            obj = reshape(obj, size(a));
        end
    end
end