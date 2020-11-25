doors = {}
currentDoors = {}
tmpDoors = {}

doorsCreated = false

-- 0: open
-- 1: closed
-- 2: locked
-- up, down, left, right
doorsState = {
    {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0},
    {0,0,0,0}, {0,0,0,0}, {0,0,0,2}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0},
    {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0},
    {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0},
    {0,0,0,0}, {0,0,0,0}, {2,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}
}

function doorsSpawn()
    createDoors('current')
end

function doors:update(dt)
    for i, door in ipairs(currentDoors) do
        checkIfPlayerTryToOpen()
    end
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

function createDoors(type, nxRoom)

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
        door.openUp = anim8.newAnimation(door.grid(1, 1), 1)
        door.openLeft = anim8.newAnimation(door.grid(2, 1), 1)
        door.openDown = anim8.newAnimation(door.grid(1, 2), 1)
        door.openRight = anim8.newAnimation(door.grid(2, 2), 1)

        door.lockedUp = anim8.newAnimation(door.grid(3, 1), 1)
        door.lockedLeft = anim8.newAnimation(door.grid(4, 1), 1)
        door.lockedDown = anim8.newAnimation(door.grid(3, 2), 1)
        door.lockedRight = anim8.newAnimation(door.grid(4, 2), 1)

        if type == 'current' then

            door.name = doorL.name

            if doorL.name == 'up' then
                door.x = doorL.x
                door.y = doorL.y + 40

                if doorsState[currentDungeonRoom][1] == 2 then
                    door.currentDoor = door.lockedUp
                    createCollisionDoors(doorL.name)
                else
                    door.currentDoor = door.openUp
                end
                
            elseif doorL.name == 'left' then
                door.x = doorL.x
                door.y = doorL.y + 32

                if doorsState[currentDungeonRoom][3] == 2 then
                    door.currentDoor = door.lockedLeft
                    createCollisionDoors(doorL.name)
                else
                    door.currentDoor = door.openLeft
                end

            elseif doorL.name == 'down' then
                door.x = doorL.x
                door.y = doorL.y + 24

                if doorsState[currentDungeonRoom][2] == 2 then
                    door.currentDoor = door.lockedDown
                    createCollisionDoors(doorL.name)
                else
                    door.currentDoor = door.openDown
                end
                
            elseif doorL.name == 'right' then
                door.x = doorL.x - 16
                door.y = doorL.y + 32

                if doorsState[currentDungeonRoom][4] == 2 then
                    door.currentDoor = door.lockedRight
                    createCollisionDoors(doorL.name)
                else
                    door.currentDoor = door.openRight
                end
            end

            table.insert(currentDoors, door)
        elseif type == 'tmp' then
            if doorL.name == 'up' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y + 40 + tmpMapY
                if doorsState[nxRoom][1] == 2 then
                    door.currentDoor = door.lockedUp
                else
                    door.currentDoor = door.openUp
                end

            elseif doorL.name == 'left' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y + 32 + tmpMapY

                if doorsState[nxRoom][3] == 2 then
                    door.currentDoor = door.lockedLeft
                else
                    door.currentDoor = door.openLeft
                end

            elseif doorL.name == 'down' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y + 24 + tmpMapY

                if doorsState[nxRoom][2] == 2 then
                    door.currentDoor = door.lockedDown
                else
                    door.currentDoor = door.openDown
                end

            elseif doorL.name == 'right' then
                door.x = doorL.x - 16 + tmpMapX
                door.y = doorL.y + 32 + tmpMapY

                if doorsState[nxRoom][4] == 2 then
                    door.currentDoor = door.lockedRight
                else
                    door.currentDoor = door.openRight
                end
            end

            table.insert(tmpDoors, door)
        end
    end
    doorsCreated = true
end

function createTmpDoors(room)
    createDoors('tmp', room)
    doorsCreated = false
end

function createCollisionDoors(direction)
    if direction == 'up' then
        upDoorCollider = world:newRectangleCollider(112, 72, 32, 16)
        upDoorCollider:setCollisionClass('Wall')
        upDoorCollider:setType('static')
        upDoorColliderExists = true
    elseif direction == 'down' then
        downDoorCollider = world:newRectangleCollider(112, 200, 32, 16)
        downDoorCollider:setCollisionClass('Wall')
        downDoorCollider:setType('static')
        downDoorColliderExists = true
    elseif direction == 'left' then
        
    elseif direction == 'right' then
        rightDoorCollider = world:newRectangleCollider(224, 136, 32, 16)
        rightDoorCollider:setCollisionClass('Wall')
        rightDoorCollider:setType('static')
        rightDoorColliderExists = true
    end
end

function checkIfPlayerTryToOpen()
    if upDoorColliderExists then
        if upDoorCollider:enter('Player') and Player.keys > 0 then
            deleteDoorCollision('up')
            Player.keys = Player.keys - 1
            doorsState[currentDungeonRoom][1] = 0
            for i, door in ipairs(currentDoors) do
                if door.name == 'up' then
                    door.currentDoor = door.openUp
                end
            end
        end
    end

    if downDoorColliderExists then
        if downDoorCollider:enter('Player') and Player.keys > 0 then
            deleteDoorCollision('down')
            Player.keys = Player.keys - 1
            doorsState[currentDungeonRoom][1] = 0
            for i, door in ipairs(currentDoors) do
                if door.name == 'down' then
                    door.currentDoor = door.openDown
                end
            end
        end
    end

    if leftDoorColliderExists then
        if leftDoorCollider:enter('Player') and Player.keys > 0 then
            deleteDoorCollision('left')
            Player.keys = Player.keys - 1
            doorsState[currentDungeonRoom][1] = 0
            for i, door in ipairs(currentDoors) do
                if door.name == 'left' then
                    door.currentDoor = door.openLeft
                end
            end
        end
    end

    if rightDoorColliderExists then
        if rightDoorCollider:enter('Player') and Player.keys > 0 then
            deleteDoorCollision('right')
            Player.keys = Player.keys - 1
            doorsState[currentDungeonRoom][1] = 0
            for i, door in ipairs(currentDoors) do
                if door.name == 'right' then
                    door.currentDoor = door.openRight
                end
            end
        end
    end
end

function deleteDoorCollision(direction)
    if direction == 'up' then
        if upDoorColliderExists then
            upDoorCollider:destroy()
            upDoorColliderExists = false
        end
    elseif direction == 'down' then
        if downDoorColliderExists then
            downDoorCollider:destroy()
            downDoorColliderExists = false
        end
    elseif direction == 'left' then

    elseif direction == 'right' then
        if rightDoorColliderExists then
            rightDoorCollider:destroy()
            rightDoorColliderExists = false
        end
    end
end

function clearDoors()
    currentDoors = {}
    tmpDoors = {}
    if upDoorColliderExists then
        upDoorCollider:destroy()
        upDoorColliderExists = false
    end
    if downDoorColliderExists then
        downDoorCollider:destroy()
        downDoorColliderExists = false
    end
end
