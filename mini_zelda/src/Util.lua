function getDirectionVector(direction)
    local vectorDirection
    if direction == 'down' then
        vectorDirection = vector(0, 1)
    elseif direction == 'left' then
        vectorDirection = vector(-1, 0)
    elseif direction == 'up' then
        vectorDirection = vector(0, -1)
    elseif direction == 'right' then
        vectorDirection = vector(1, 0)
    end
    return vectorDirection
end