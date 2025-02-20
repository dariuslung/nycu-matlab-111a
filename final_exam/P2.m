% ID: 109550194
% Name: 龍偉亮

classdef P2
   properties
       x = 0;
       y = 0;
       r = 1;
   end
   
   methods
       function obj = P2(x, y, r)
           if nargin == 0
               return
           elseif nargin == 3
               if ~all(size(x) == size(y)) == all(size(y) == size(r))
                   error("ERROR x y r have different sizes");
               else
                   if any(r(:) < 0)
                       error("r cannot contain negative elements");
                   end
                   obj.x = x;
                   obj.y = y;
                   obj.r = r;
               end
           else
               error("ERROR constructing P2");
           end
       end
       
       function obj = set.r(obj, r)
           if r < 0
               error("r must be non-negative");
           elseif ~isscalar(obj)
               error("Object must be scalar");
           end
           obj.r = r;
       end
       
       function disp(a)
           for i = 1:numel(a.x)
                fprintf('(%f,%f,%f)', a.x(i), a.y(i), a.r(i));
           end
       end
       
       function out = lt(a, b)
           
       end
   end
end