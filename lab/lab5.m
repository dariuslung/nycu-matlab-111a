A = round(100*rand(3,4))
v = max2d(A)
[v,n] = max2d(A)
[v,r,c] = max2d(A)
v = max2d(A,3)
[v,n] = max2d(A,3)
[v,r,c] = max2d(A,3)
% v = max2d(A,30) % should be error
% v = max2d([]) % should be error
% v = max2d(A,0) % should be error
% v = max2d(A,[]) % should be error
% v = max2d(A,1,2) % should be error

function [v, r, c] = max2d(A, k)
    validateattributes(A, {'numeric'}, {'nonempty'});
    switch nargin
        case 1
            switch nargout
                case 1
                    v = max(A(:));
                case 2
                    [v, n] = max(A(:));
                    r = n;
                case 3
                    [v, n] = max(A(:));
                    [r, c] = ind2sub(size(A), n);
                otherwise
                    sprintf('ERROR: input arguments %d, output arguments %d', nargin, nargout)
            end
        case 2
            validateattributes(k, {'numeric'}, {'>', 1, '<', numel(A), 'scalar'})
            switch nargout
                case 1
                    v = sort(A(:), 'descend');
                    v = v(1:k);
                case 2
                    [v, n] = sort(A(:), 'descend');
                    v = v(1:k);
                    r = n(1:k);
                case 3
                    [v, n] = sort(A(:), 'descend');
                    [r, c] = ind2sub(size(A), n);
                    v = v(1:k);
                    r = r(1:k);
                    c = c(1:k);
                otherwise
                    sprintf('ERROR: input arguments %d, output arguments %d', nargin, nargout)
            end
        otherwise
            sprintf('ERROR: input arguments %d, output arguments %d', nargin, nargout)
    end
end