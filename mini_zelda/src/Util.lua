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

function distanceFrom(x1,y1, x2,y2) 
    return ((x2-x1)^2+(y2-y1)^2)^0.5 
end

function checkDistance(x1, y1, x2, y2)
    distX =  x1 - x2
    distY =  y1 - y2
    distance = math.sqrt(distX*distX+distY*distY)
    locationX = distX/distance*10
    locationY = distY/distance*10
    return locationX, locationY
end

-- round down a number for a 16 multiple
function multiple16(n)
    if n % 16 ~= 0 then
        local subtract = n % 16
        n = n - subtract
        return n
    else
        return n
    end
end

function invertNumber(num)
    if num > 0 then
        num = -num
    elseif num < 0 then
        num = math.abs(num)
    end

    return num
end

function checkArea(x, y)

    cLeft = world:queryCircleArea(x-9, y, 4, {'Wall'})
    cRight = world:queryCircleArea(x+9, y, 4, {'Wall'})
    cBack = world:queryCircleArea(x, y+9, 4, {'Wall'})
    cFront = world:queryCircleArea(x, y-9, 4, {'Wall'})

    directAvailable = {}
    if #cLeft <= 0 then
        table.insert(directAvailable, 'left')
    end
    if #cRight <= 0 then
        table.insert(directAvailable, 'right')
    end
    if #cBack <= 0 then
        table.insert(directAvailable, 'down')
    end
    if #cFront <= 0 then
        table.insert(directAvailable, 'up')
    end

    return directAvailable
end

function checkIfSeePlayer(x, y, facing)
    local locationX, locationY = checkDistance(Player.x, player.y, x, y)
    if facing == 'up' and (locationX <= 1 and locationX >= -1) and locationY <= 0 then
        return true
    elseif facing == 'left' and (locationY <= 1 and locationY >= -1) and locationX <= 0 then
        return true
    elseif facing == 'down' and (locationX <= 1 and locationX >= -1) and locationY >= 0 then
        return true
    elseif facing == 'right' and (locationY <= 1 and locationY >= -1) and locationX >= 0 then
        return true
    end
    return false
end

function copyTable(table)
    local tableCopy = {}
    for i, t in pairs(table) do
        tableCopy[i] = t
    end
    return tableCopy
end
