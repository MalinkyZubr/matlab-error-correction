function mustBeLength(array, length)
    if numel(array) ~= length
        error('array length %d, must be %d', numel(array), length);
    end
end