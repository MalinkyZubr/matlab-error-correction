function mustBeEqualSize(a,b)
    % Test for equal size
    if ~isequal(size(a),size(b))
        disp(size(a));
        disp(size(b));
        eid = 'Size:notEqual';
        msg = 'Size of first input must equal size of second input';
        error(eid,msg)
    end
end