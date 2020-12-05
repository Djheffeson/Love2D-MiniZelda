wallMasters = {}

function spawnWallMaster()
    local wallMaster = {}

    repeat
        wallMaster.x = multiple16(math.random(48, 132))
        wallMaster.y = multiple16(math.random(88, 132))
    until checkLayer('Ground_layer', map:convertPixelToTile(wallMaster.x+12, wallMaster.y+12)) == 'dungeon_brick'

    wallMaster.targetX = 0
    wallMaster.targetY = 0

    wallMaster.vectorX = 0
    wallMaster.vectorY = 0

    wallMaster.speed = 16
    wallMaster.attack = false
    wallMaster.attackDirection = 'none'
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

    for i, wallMaster in ipairs(wallMasters) do
        wallMaster.animation:update(dt)
        wallMaster.x, wallMaster.y = wallMaster.collider:getPosition()

        if wallMaster.attack == false then
            wallMaster.targetX = multiple16(Player.x)+8
            wallMaster.targetY = multiple16(Player.y)
        end

        if Player.y >= 192 and wallMaster.attack == false then
            wallMaster.attack = true
            wallMaster.attackPosition = 'down'
            wallMaster.outTimer = 0
        elseif Player.y <= 100 and wallMaster.attack == false then
            wallMaster.attack = true
            wallMaster.attackPosition = 'up'
            wallMaster.outTimer = 0
        elseif Player.x >= 210 and wallMaster.attack == false then
            wallMaster.attack = true
            wallMaster.attackPosition = 'right'
            wallMaster.outTimer = 0
        end

        if wallMaster.attack == true then
            wallMasterAttack(i, wallMaster.attackPosition, dt)
        end

        if wallMaster.isReturning then
            if wallMaster.x <= 0 or wallMaster.x >= 255 then
                -- TODO
                print('return')
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
            wallMaster.collider:setPosition(wallMaster.targetX+64, wallMaster.targetY+32)
            wallMaster.setPosition = true
            wallMaster.direction = 'up'
            return
        elseif direction == 'up' then
            wallMaster.collider:setPosition(wallMaster.targetX+64, wallMaster.targetY-32)
            wallMaster.animation:flipV()
            wallMaster.setPosition = true
            wallMaster.direction = 'down'
        elseif direction == 'right' then
            wallMaster.collider:setPosition(wallMaster.targetX+48, wallMaster.targetY+32)
            wallMaster.setPosition = true
            wallMaster.direction = 'left'
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

function deleteWallMasters()
    for i, wallMaster in ipairs(wallMasters) do
        if wallMaster.colliderExists then
            wallMaster.collider:destroy()
            wallMaster.colliderExists = false
        end
        table.remove(wallMasters, i)
    end
end
