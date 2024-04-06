function mustBeOdd(number)
    if (mod(number, 2) == 0)
        eid = 'Value:notOdd';
        msg = 'Number must be odd.';
        error(eid,msg)
    end
end