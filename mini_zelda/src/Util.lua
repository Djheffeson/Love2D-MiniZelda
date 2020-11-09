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

function contains(value, list)
    for _, v in pairs(list) do
        if v == value then
            return true
        end
    end
    return false
end
