doors = {}
currentDoors = {}
tmpDoors = {}

doorsCreated = false

-- 0: open
-- 1: closed
-- 2: locked
-- up, down, left, right
doorsState = {
    {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,1}, {0,0,0,0},
    {0,0,0,0}, {0,0,1,0}, {0,0,0,2}, {0,0,0,0}, {2,0,0,0}, {0,0,0,0},
    {0,0,0,0}, {2,0,0,1}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0},
    {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0},
    {0,0,0,0}, {0,0,0,0}, {2,0,0,0}, {0,0,0,0}, {0,0,0,0}, {0,0,0,0}
}

function doorsSpawn()
    closedDoors = {}
    closedDoorsCreated = false
    createDoors('current')
end

function doors:update(dt)

    -- reset the doors
    if gameState == 'changingRoom' then
        doorsState[14][4] = 1
        doorsState[5][4] = 1
        doorsState[8][3] = 1
    end

    if gameState == 'running' and closedDoorsCreated == false then
        -- iterates for al the doors and close some
        for i, door in ipairs(currentDoors) do
            for j, closedDoor in ipairs(closedDoors) do
                if door.name == closedDoor then

                    if door.name == 'up' then door.currentDoor = door.closedUp end
                    if door.name == 'down' then door.currentDoor = door.closedDown end
                    if door.name == 'left' then door.currentDoor = door.closedLeft end
                    if door.name == 'right' then door.currentDoor = door.closedRight end
                    createCollisionDoors(door.name)
                    closedDoorsCreated = true
                end
            end
        end
    end

    for i, door in ipairs(currentDoors) do
        checkIfPlayerTryToOpen()
        closedDoorsLogic(i)
    end
end

function doors:draw()
    if Map.type == 'dungeon_1' and gameState ~= 'death' then
        
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

        door.grid = anim8.newGrid(16, 16, sprites.dungeonDoors:getWidth(), sprites.dungeonDoors:getHeight())

        door.air = anim8.newAnimation(door.grid(5, 1), 1)

        door.lockedUp = anim8.newAnimation(door.grid(1, 1), 1)
        door.lockedLeft = anim8.newAnimation(door.grid(2, 1), 1)
        door.lockedDown = anim8.newAnimation(door.grid(1, 2), 1)
        door.lockedRight = anim8.newAnimation(door.grid(2, 2), 1)

        door.closedUp = anim8.newAnimation(door.grid(3, 1), 1)
        door.closedLeft = anim8.newAnimation(door.grid(4, 1), 1)
        door.closedDown = anim8.newAnimation(door.grid(3, 2), 1)
        door.closedRight = anim8.newAnimation(door.grid(4, 2), 1)

        if doorL.name == nil then
            goto continue
        end
        door.name = doorL.name
        if type == 'current' then

            door.currentDoor = door.air

            if doorL.name == 'up' then

                door.x = doorL.x
                door.y = doorL.y + 40

                if doorsState[currentDungeonRoom][1] == 0 then
                    goto continue

                elseif doorsState[currentDungeonRoom][1] == 1 then

                    -- check if a door that player is going to walk thru is gonna be closed
                    if Player.direction == 'down' then
                        Player.enterInClosedDoor = true
                    end
                    table.insert(closedDoors, doorL.name)

                elseif doorsState[currentDungeonRoom][1] == 2 then
                    door.currentDoor = door.lockedUp
                    createCollisionDoors(doorL.name, 2)
                end
            elseif doorL.name == 'left' then

                door.x = doorL.x
                door.y = doorL.y + 40

                if doorsState[currentDungeonRoom][3] == 0 then
                    goto continue
                    
                elseif doorsState[currentDungeonRoom][3] == 1 then

                    -- check if a door that player is going to walk thru is gonna be closed
                    if Player.direction == 'right' then
                        Player.enterInClosedDoor = true
                    end
                    table.insert(closedDoors, doorL.name)

                elseif doorsState[currentDungeonRoom][3] == 2 then
                    door.currentDoor = door.lockedLeft
                    createCollisionDoors(doorL.name, 2)
                end
            elseif doorL.name == 'down' then

                door.x = doorL.x
                door.y = doorL.y + 40

                if doorsState[currentDungeonRoom][2] == 0 then
                    goto continue

                elseif doorsState[currentDungeonRoom][2] == 1 then
                    
                    -- check if a door that player is going to walk thru is gonna be closed
                    if Player.direction == 'up' then
                        Player.enterInClosedDoor = true
                    end
                    table.insert(closedDoors, doorL.name)

                elseif doorsState[currentDungeonRoom][2] == 2 then
                    door.currentDoor = door.lockedDown
                    createCollisionDoors(doorL.name, 2)
                end
            elseif doorL.name == 'right' then

                door.x = doorL.x
                door.y = doorL.y + 40

                if doorsState[currentDungeonRoom][4] == 0 then
                    goto continue
                    
                elseif doorsState[currentDungeonRoom][4] == 1 then

                    -- check if a door that player is going to walk thru is gonna be closed
                    if Player.direction == 'left' then
                        Player.enterInClosedDoor = true
                    end
                    table.insert(closedDoors, doorL.name)

                elseif doorsState[currentDungeonRoom][4] == 2 then
                    door.currentDoor = door.lockedRight
                    createCollisionDoors(doorL.name, 2)
                end
            end

            table.insert(currentDoors, door)
        elseif type == 'tmp' then
            if doorL.name == 'up' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y + 40 + tmpMapY

                if doorsState[nxRoom][1] == 0 or doorsState[nxRoom][1] == 1 then
                    goto continue
                elseif doorsState[nxRoom][1] == 2 then
                    door.currentDoor = door.lockedUp
                end

            elseif doorL.name == 'left' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y  + 40 + tmpMapY

                if doorsState[nxRoom][3] == 0 or doorsState[nxRoom][3] == 1 then
                    goto continue
                elseif doorsState[nxRoom][3] == 2 then
                    door.currentDoor = door.lockedLeft
                end

            elseif doorL.name == 'down' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y + 40 + tmpMapY

                if doorsState[nxRoom][2] == 0 or doorsState[nxRoom][2] == 1 then
                    goto continue
                elseif doorsState[nxRoom][2] == 2 then
                    door.currentDoor = door.lockedDown
                end

            elseif doorL.name == 'right' then
                door.x = doorL.x + tmpMapX
                door.y = doorL.y + 40 + tmpMapY

                if doorsState[nxRoom][4] == 0 or doorsState[nxRoom][4] == 1 then
                    goto continue
                elseif doorsState[nxRoom][4] == 2 then
                    door.currentDoor = door.lockedRight
                end
            end

            table.insert(tmpDoors, door)
        end
        ::continue::
    end
    doorsCreated = true
end

function createTmpDoors(room)
    createDoors('tmp', room)
    doorsCreated = false
end

function createCollisionDoors(direction, type)

    if direction == 'up' then
        upDoorCollider = world:newRectangleCollider(112, 72, 32, 15)
        upDoorCollider:setCollisionClass('Wall')
        upDoorCollider:setType('static')
        upDoorColliderExists = true
        if type == 2 then
            upDoorColliderIsLocked = true
        else
            upDoorColliderIsLocked = false
        end

    elseif direction == 'down' then
        downDoorCollider = world:newRectangleCollider(112, 201, 32, 16)
        downDoorCollider:setCollisionClass('Wall')
        downDoorCollider:setType('static')
        downDoorColliderExists = true
        if type == 2 then
            downDoorColliderIsLocked = true
        else
            downDoorColliderIsLocked = false
        end

    elseif direction == 'left' then
        leftDoorCollider = world:newRectangleCollider(16, 136, 15, 16)
        leftDoorCollider:setCollisionClass('Wall')
        leftDoorCollider:setType('static')
        leftDoorColliderExists = true
        if type == 2 then
            leftDoorColliderIsLocked = true
        else
            leftDoorColliderIsLocked = false
        end

    elseif direction == 'right' then
        rightDoorCollider = world:newRectangleCollider(225, 136, 16, 16)
        rightDoorCollider:setCollisionClass('Wall')
        rightDoorCollider:setType('static')
        rightDoorColliderExists = true
        if type == 2 then
            rightDoorColliderIsLocked = true
        else
            rightDoorColliderIsLocked = false
        end
    end
end

function checkIfPlayerTryToOpen()
    if upDoorColliderExists then
        if upDoorCollider:enter('Player') and upDoorColliderIsLocked and Player.keys > 0 then
            deleteDoorCollision('up')
            Player.keys = Player.keys - 1
            doorsState[currentDungeonRoom][1] = 0
            for i, door in ipairs(currentDoors) do
                if door.name == 'up' then
                    table.remove(currentDoors, i)
                    sounds.openDoor:stop()
                    sounds.openDoor:play()
                end
            end
            upDoorColliderIsLocked = false
        end
    end

    if downDoorColliderExists then
        if downDoorCollider:enter('Player') and downDoorColliderIsLocked and Player.keys > 0 then
            deleteDoorCollision('down')
            Player.keys = Player.keys - 1
            doorsState[currentDungeonRoom][2] = 0
            for i, door in ipairs(currentDoors) do
                if door.name == 'down' then
                    table.remove(currentDoors, i)
                    sounds.openDoor:stop()
                    sounds.openDoor:play()
                end
            end
            downDoorColliderIsLocked = false
        end
    end

    if leftDoorColliderExists then
        if leftDoorCollider:enter('Player') and leftDoorColliderIsLocked and Player.keys > 0 then
            deleteDoorCollision('left')
            Player.keys = Player.keys - 1
            doorsState[currentDungeonRoom][3] = 0
            for i, door in ipairs(currentDoors) do
                if door.name == 'left' then
                    table.remove(currentDoors, i)
                    sounds.openDoor:stop()
                    sounds.openDoor:play()
                end
            end
            leftDoorColliderIsLocked = false
        end
    end

    if rightDoorColliderExists then
        if rightDoorCollider:enter('Player') and rightDoorColliderIsLocked and Player.keys > 0 then
            deleteDoorCollision('right')
            Player.keys = Player.keys - 1
            doorsState[currentDungeonRoom][4] = 0
            for i, door in ipairs(currentDoors) do
                if door.name == 'right' then
                    table.remove(currentDoors, i)
                    sounds.openDoor:stop()
                    sounds.openDoor:play()
                end
            end
            rightDoorColliderIsLocked = false
        end
    end
end

function closedDoorsLogic(index)
    local door = currentDoors[index]
    local enemiesNumber = enemiesDungeon1_rooms[currentDungeonRoom]

    if door == nil then
        return
    end

    if currentDungeonRoom == 14 and enemiesNumber[1] <= 0 then
        if door.name == 'right' and doorsState[currentDungeonRoom][4] == 1 then
            table.remove(currentDoors, index)
            doorsState[currentDungeonRoom][4] = 0
            sounds.openDoor:stop()
            sounds.openDoor:play()
            deleteDoorCollision('right')
        end

    elseif currentDungeonRoom == 5 and enemiesNumber[6] <= 0 then
        if door.name == 'right' and doorsState[currentDungeonRoom][4] == 1 then
            table.remove(currentDoors, index)
            doorsState[currentDungeonRoom][4] = 0
            sounds.openDoor:stop()
            sounds.openDoor:play()
            deleteDoorCollision('right')
        end

    elseif currentDungeonRoom == 8 and enemiesNumber[2] <= 0 then
        if door.name == 'left' and doorsState[currentDungeonRoom][3] == 1 then
            table.remove(currentDoors, index)
            doorsState[currentDungeonRoom][3] = 0
            sounds.openDoor:stop()
            sounds.openDoor:play()
            deleteDoorCollision('left')
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
        if leftDoorColliderExists then
            leftDoorCollider:destroy()
            leftDoorColliderExists = false
        end
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
    clearDoorsCollisions()
end

function clearDoorsCollisions()
    if upDoorColliderExists then
        upDoorCollider:destroy()
        upDoorColliderExists = false
    end
    if downDoorColliderExists then
        downDoorCollider:destroy()
        downDoorColliderExists = false
    end
    if leftDoorColliderExists then
        leftDoorCollider:destroy()
        leftDoorColliderExists = false
    end
    if rightDoorColliderExists then
        rightDoorCollider:destroy()
        rightDoorColliderExists = false
    end
end
