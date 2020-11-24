doors = {}
currentDoors = {}
tmpDoors = {}

doorsCreated = false

function doorsSpawn()
    createDoors('current')
end

function doors:update(dt)
    
end

function doors:draw()
    if Map.type == 'dungeon_1' then
        for i, door in ipairs(currentDoors) do
            door.currentDoor:draw(sprites.dungeonDoors, door.x, door.y) 
        end

        if gameState == 'changingRoom' then
            for i, door in ipairs(tmpDoors) do
                door.currentDoor:draw(sprites.dungeonDoors, door.x, door.y) 
            end
        end
    end
end

function createDoors(type)

    if doorsCreated then
        return
    end

    if type == 'current' then
        doorLayer = map.layers[4].objects
    elseif type == 'tmp' then
        doorLayer = tmpMap.layers[5].objects
    end

    for i, doorL in pairs(doorLayer) do
        local door = {}

        door.grid = anim8.newGrid(32, 32, sprites.dungeonDoors:getWidth(), sprites.dungeonDoors:getHeight())
        door.up = anim8.newAnimation(door.grid(1, 1), 1)
        door.left = anim8.newAnimation(door.grid(2, 1), 1)
        door.down = anim8.newAnimation(door.grid(1, 2), 1)
        door.right = anim8.newAnimation(door.grid(2, 2), 1)

        if type == 'current' then
            if doorL.name == 'up' then
                door.x = doorL.x
                door.y = doorL.y + 40
                door.currentDoor = door.up
            elseif doorL.name == 'left' then
                door.x = doorL.x
                door.y = doorL.y + 32
                door.currentDoor = door.left
            elseif doorL.name == 'down' then
                door.x = doorL.x
                door.y = doorL.y + 24
                door.currentDoor = door.down
            elseif doorL.name == 'right' then
                door.x = doorL.x - 16
                door.y = doorL.y + 32
                door.currentDoor = door.right
            end

            table.insert(currentDoors, door)
        elseif type == 'tmp' then
            if doorL.name == 'up' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y + 40 + tmpMapY
                door.currentDoor = door.up
            elseif doorL.name == 'left' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y + 32 + tmpMapY
                door.currentDoor = door.left
            elseif doorL.name == 'down' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y + 24 + tmpMapY
                door.currentDoor = door.down
            elseif doorL.name == 'right' then
                door.x = doorL.x - 16 + tmpMapX
                door.y = doorL.y + 32 + tmpMapY
                door.currentDoor = door.right
            end

            table.insert(tmpDoors, door)
        end
    end
    doorsCreated = true
end

function createTmpDoors()
    createDoors('tmp')
    doorsCreated = false
end

function clearDoors()
    currentDoors = {}
    tmpDoors = {}
end
