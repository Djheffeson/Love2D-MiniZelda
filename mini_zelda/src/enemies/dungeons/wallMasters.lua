wallMasters = {}
wallMasterRoom = false

local wallMasterLimit = 3
local wallMasterTimer = 1.5

function spawnWallMaster(attackDirection)
    local wallMaster = {}

    wallMaster.x = -16
    wallMaster.y = -16

    wallMaster.targetX = 0
    wallMaster.targetY = 0

    wallMaster.vectorX = 0
    wallMaster.vectorY = 0

    wallMaster.health = 2
    wallMaster.damage = 0.5
    wallMaster.speed = 22
    wallMaster.attack = false
    wallMaster.attackPosition = attackDirection
    wallMaster.direction = 'none'
    wallMaster.setPosition = false
    wallMaster.reachTarget = false
    wallMaster.isReturning = false
    wallMaster.invincible = false
    wallMaster.grabPlayer = false

    wallMaster.grid = anim8.newGrid(16, 16, sprites.wallMaster:getWidth(), sprites.wallMaster:getHeight())
    wallMaster.animation = anim8.newAnimation(wallMaster.grid('1-2', 1), 0.15)

    wallMaster.collider = world:newRectangleCollider(wallMaster.x, wallMaster.y-8, 16, 16)
    wallMaster.collider:setCollisionClass('IgnoreAll')
    wallMaster.collider:setFixedRotation(true)
    wallMaster.colliderExists = true

    wallMaster.invincibleTimer = 0

    table.insert(wallMasters, wallMaster)
end

function wallMasters:update(dt)

    if Map.type == 'dungeon_1' and wallMasterRoom and gameState == 'running' then

        if enemiesDungeon1_rooms[currentDungeonRoom][5] < wallMasterLimit then
            wallMasterLimit = enemiesDungeon1_rooms[currentDungeonRoom][5]
        end

        wallMasterTimer = wallMasterTimer + 1 * dt
        if wallMasterTimer >= 1.5 and #wallMasters < wallMasterLimit then

            if Player.y <= 100 then
                spawnWallMaster('up')
                wallMasterTimer = 0
            end
            if Player.y >= 192 then
                spawnWallMaster('down')
                wallMasterTimer = 0
            end
            if Player.x <= 40 and Player.x >= 32 then
                spawnWallMaster('left')
                wallMasterTimer = 0
            end
            if Player.x >= 210 then
                spawnWallMaster('right')
                wallMasterTimer = 0
            end
        end
    end

    for i, wallMaster in ipairs(wallMasters) do

        wallMasterCheckDamage(i)
        checkIfWallMasterGrabsPlayer(i)

        if wallMaster.health <= 0 then
            wallMasterDeath(i)
            goto continue
        end

        if wallMaster.grabPlayer == true then
            Player.collider:setPosition(wallMaster.x, wallMaster.y)
        end

        if wallMaster.invincible == true then
            wallMaster.invincibleTimer = wallMaster.invincibleTimer + 1 * dt
            if wallMaster.invincibleTimer >= 0.750 then
                wallMaster.invincible = false
            end
        end

        wallMaster.animation:update(dt)
        wallMaster.x, wallMaster.y = wallMaster.collider:getPosition()

        if wallMaster.attack == false then
            wallMaster.targetX = multiple16(Player.x)+8
            wallMaster.targetY = multiple16(Player.y+8)
        end

        if wallMaster.attack == false then
            wallMaster.attack = true
        end

        if wallMaster.attack == true then
            wallMasterAttack(i, wallMaster.attackPosition, dt)
        end

        if wallMaster.isReturning then
            if wallMaster.x <= 0 or wallMaster.x >= 256 then
                removeWallMaster(i, dt)
            end

            if wallMaster.y <= 56 or wallMaster.y >= 224 then
                removeWallMaster(i, dt)
            end
        end
    end
    ::continue::
end

function wallMasters:draw()
    for i, wallMaster in ipairs(wallMasters) do
        if wallMaster.invincible == true then
            if math.floor(math.cos(love.timer.getTime() * 18 % 2 * math.pi)) == 0 then
                love.graphics.setShader(white_flash)
            end
        end
        wallMaster.animation:draw(sprites.wallMaster, wallMaster.x-8, wallMaster.y-8)
        love.graphics.setShader()
    end
end

function wallMasterAttack(index, direction, dt)

    local wallMaster = wallMasters[index]
    

    if wallMaster.setPosition == false then

        local x = wallMaster.targetX
        local y = wallMaster.targetY

        if direction == 'up' or direction == 'down' then
            if wallMaster.targetX >= 128 then
                x = 64
            else
                x = -64
                wallMaster.animation:flipH()
            end
        else
            if wallMaster.targetY >= 140 then
                y = 48
            else
                y = -48
                wallMaster.animation:flipV()
            end
        end

        if direction == 'down' then
            wallMaster.collider:setPosition(wallMaster.targetX+x, wallMaster.targetY+40)
            wallMaster.setPosition = true
            wallMaster.direction = 'up'
            
        elseif direction == 'up' then
            wallMaster.collider:setPosition(wallMaster.targetX+x, wallMaster.targetY-40)
            wallMaster.setPosition = true
            wallMaster.direction = 'down'
            wallMaster.animation:flipV()
            
        elseif direction == 'right' then
            wallMaster.collider:setPosition(wallMaster.targetX+40, wallMaster.targetY+y)
            wallMaster.setPosition = true
            wallMaster.direction = 'left'
            
        elseif direction == 'left' then
            wallMaster.collider:setPosition(wallMaster.targetX-40, wallMaster.targetY+y)
            wallMaster.setPosition = true
            wallMaster.direction = 'right'
        end
    end
    wallMaster.x, wallMaster.y = wallMaster.collider:getPosition()

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

function checkIfWallMasterGrabsPlayer(index)
    local wallMaster = wallMasters[index]
    if wallMaster.collider:enter('Player') then
        Player.hearts = Player.hearts - wallMaster.damage
        wallMaster.grabPlayer = true
        Player.grabbed = true
    end
end

function wallMasterCheckDamage(index)
    local wallMaster = wallMasters[index]
    if wallMaster.collider:enter('Weapon') or wallMaster.collider:enter('Arrow') and wallMaster.invincible == false then
        wallMaster.health = wallMaster.health - Sword.damage
        wallMaster.invincible = true
        wallMaster.invincibleTimer = 0
    end
end

function wallMasterDeath(index)
    local wallMaster = wallMasters[index]

    deathSpawn(wallMaster.x-8, wallMaster.y-8, enemyDrops())
    removeWallMaster(index)
    enemiesDungeon1_rooms[currentDungeonRoom][5] = enemiesDungeon1_rooms[currentDungeonRoom][5] - 1
end

function removeWallMaster(index, dt)
    local wallMaster = wallMasters[index]

    if wallMaster.grabPlayer == true then
        wallMaster.grabPlayer = false
        Player.grabbed = false
        playerWasReleased()
    end

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
