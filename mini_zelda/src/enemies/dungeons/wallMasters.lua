wallMasters = {}
wallMasterRoom = false

function spawnWallMaster(attackDirection)
    local wallMaster = {}

    wallMaster.x = -16
    wallMaster.y = -16

    wallMaster.targetX = 0
    wallMaster.targetY = 0

    wallMaster.vectorX = 0
    wallMaster.vectorY = 0

    wallMaster.speed = 22
    wallMaster.attack = false
    wallMaster.attackPosition = attackDirection
    wallMaster.direction = 'none'
    wallMaster.setPosition = false
    wallMaster.reachTarget = false
    wallMaster.isReturning = false

    wallMaster.grid = anim8.newGrid(16, 16, sprites.wallMaster:getWidth(), sprites.wallMaster:getHeight())
    wallMaster.animation = anim8.newAnimation(wallMaster.grid('1-2', 1), 0.15)

    wallMaster.collider = world:newRectangleCollider(wallMaster.x, wallMaster.y-8, 16, 16)
    wallMaster.collider:setCollisionClass('IgnoreAll')
    wallMaster.collider:setFixedRotation(true)
    wallMaster.colliderExists = true

    wallMaster.outTimer = 0

    table.insert(wallMasters, wallMaster)
end

function wallMasters:update(dt)

    if Map.type == 'dungeon_1' and wallMasterRoom and gameState == 'running' then
        if #wallMasters < 2 then
            if Player.y <= 100 then
                spawnWallMaster('up')

            elseif Player.y >= 192 then
                spawnWallMaster('down')

            elseif Player.x <= 40 and Player.x >= 32 then
                spawnWallMaster('left')

            elseif Player.x >= 210 then
                spawnWallMaster('right')
            end
        end
    end

    for i, wallMaster in ipairs(wallMasters) do
        wallMaster.animation:update(dt)
        wallMaster.x, wallMaster.y = wallMaster.collider:getPosition()

        if wallMaster.attack == false then
            wallMaster.targetX = multiple16(Player.x)+8
            wallMaster.targetY = multiple16(Player.y+8)
        end

        if wallMaster.attack == false then
            wallMaster.attack = true
            wallMaster.outTimer = 0
        end

        if wallMaster.attack == true then
            wallMasterAttack(i, wallMaster.attackPosition, dt)
        end

        if wallMaster.isReturning then
            if wallMaster.x <= 0 or wallMaster.x >= 256 then
                removeWallMaster(i)
            end

            if wallMaster.y <= 56 or wallMaster.y >= 224 then
                removeWallMaster(i)
            end
        end
    end
end

function wallMasters:draw()
    for i, wallMaster in ipairs(wallMasters) do
        wallMaster.animation:draw(sprites.wallMaster, wallMaster.x-8, wallMaster.y-8)
    end
end

function wallMasterAttack(index, direction, dt)

    local wallMaster = wallMasters[index]

    if wallMaster.setPosition == false then
        if direction == 'down' then
            wallMaster.collider:setPosition(wallMaster.targetX+64, wallMaster.targetY+40)
            wallMaster.setPosition = true
            wallMaster.direction = 'up'
            return
        elseif direction == 'up' then
            wallMaster.collider:setPosition(wallMaster.targetX+64, wallMaster.targetY-40)
            wallMaster.animation:flipV()
            wallMaster.setPosition = true
            wallMaster.direction = 'down'
        elseif direction == 'right' then
            wallMaster.collider:setPosition(wallMaster.targetX+40, wallMaster.targetY+48)
            wallMaster.setPosition = true
            wallMaster.direction = 'left'
        elseif direction == 'left' then
            wallMaster.collider:setPosition(wallMaster.targetX-40, wallMaster.targetY+48)
            wallMaster.setPosition = true
            wallMaster.direction = 'right'
        end
    end
    wallMaster.x, wallMaster.y = wallMaster.collider:getPosition()

    wallMaster.outTimer = wallMaster.outTimer + 1 * dt
    if wallMaster.outTimer <= 1.5 * (index-1) then
        return
    end

    local distance = math.floor(distanceFrom(wallMaster.x, wallMaster.y, wallMaster.targetX, wallMaster.targetY))
    local distanceX = math.floor(wallMaster.x - wallMaster.targetX)
    local distanceY = math.floor(wallMaster.y - wallMaster.targetY)
    if distance == 0 then
        wallMaster.reachTarget = true
    end

    if wallMaster.reachTarget then
        wallMaster.direction = wallMaster.attackPosition
        wallMaster.isReturning = true
    end

    if (wallMaster.attackPosition == 'up' or wallMaster.attackPosition == 'down') and distanceY == 0 then

        if distanceX ~= 0 and wallMaster.reachTarget == false then
            if wallMaster.x > wallMaster.targetX then
                wallMaster.direction = 'left'
            elseif wallMaster.x < wallMaster.targetX then
                wallMaster.direction = 'right'
            end
        end

    elseif (wallMaster.attackPosition == 'left' or wallMaster.attackPosition == 'right') and distanceX == 0 then

        if distanceY ~= 0 and wallMaster.reachTarget == false then
            if wallMaster.y > wallMaster.targetY then
                wallMaster.direction = 'up'
            elseif wallMaster.y < wallMaster.targetY then
                wallMaster.direction = 'down'
            end
        end
    end

    wallMaster.vectorX, wallMaster.vectorY = getDirectionVector(wallMaster.direction):unpack()
    wallMaster.collider:setLinearVelocity(wallMaster.vectorX * wallMaster.speed, wallMaster.vectorY * wallMaster.speed)
end

function removeWallMaster(index)
    local wallMaster = wallMasters[index]

    if wallMaster.colliderExists then
        wallMaster.collider:destroy()
        wallMaster.colliderExists = false
    end
    table.remove(wallMasters, index)
end

function deleteWallMasters()
    for i, wallMaster in ipairs(wallMasters) do
        if wallMaster.colliderExists then
            wallMaster.collider:destroy()
            wallMaster.colliderExists = false
        end
        table.remove(wallMasters, i)
    end
end
