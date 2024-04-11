function mustBeOdd(number)
    if mod(number, 2) == 0
        error("Number must be odd!");
    end
end