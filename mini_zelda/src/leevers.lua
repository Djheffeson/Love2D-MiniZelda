leevers = {}

function spawnLeever(type)

    local leever = {}
    
    leever.type = type

    local x, y
    repeat
        x = multiple16(love.math.random(16,256))
        y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(x+12, y+12)) == 'sand'

    leever.x = x
    leever.y = y

    leever.vectorX = 0
    leever.vectorY = 0

    leever.hasPosition = false
    leever.state = 'none'
    leever.attackingDirection = 'none'

    leever.drops = {1}

    leever.speed = 40

    leever.grid = anim8.newGrid(16, 16, sprites.leeverSheet:getWidth(), sprites.leeverSheet:getHeight())
    leever.groundAnimation = anim8.newAnimation(leever.grid('1-2', 1), 0.117)
    leever.currentAnimation = leever.groundAnimation

    if leever.type == 'red' then
        leever.emergingAnimation = anim8.newAnimation(leever.grid(1, 2), 2)
        leever.walkingAnimation = anim8.newAnimation(leever.grid('2-3', 2), 0.1)
        leever.damage = 0.5
        leever.health = 1
    elseif leever.type == 'blue' then
        leever.emergingAnimation = anim8.newAnimation(leever.grid(1, 3), 2)
        leever.walkingAnimation = anim8.newAnimation(leever.grid('2-3', 3), 0.1)

        leever.damage = 1
        leever.health = 2
    end

    leever.colliderExists = false

    leever.emergeTimer = 0
    leever.dippingTimer = 0

    local spawnTime = 1
    for i, lv in ipairs(leevers) do
        spawnTime = spawnTime + 0.5
    end
    leever.initializeTimer = spawnTime

    table.insert(leevers, leever)
end

function leevers:update(dt)
    for i, leever in ipairs(leevers) do
        if leever.health > 0 then
            if leever.initializeTimer <= 0 then

                if leever.emergeTimer <= 0.433 then
                    leever.state = 'emerge'
                end

                if leever.state == 'emerge' then
                    leeverEmerge(i, dt)
                end

                if leever.state == 'attacking' then
                    leeverAttacking(i, dt)
                end

                if leever.state == 'dipping' then
                    leeverDipping(i, dt)
                end

                if leever.colliderExists == true then
                    leever.x, leever.y = leever.collider:getPosition()
                    checkIfReceiveDamage(i)
                    checkIfHitPlayer(i)
                end
            else
                leever.initializeTimer = leever.initializeTimer - 1 * dt
            end
        else
            if leever.colliderExists == true then
                leever.collider:destroy()
                leever.colliderExists = false
            end
            deathSpawn(leever.x-8, leever.y-8, leeverDrop(leever.drops))
            table.remove(leevers, i)
        end
    end
end

function leevers:draw()
    for i, leever in ipairs(leevers) do
        if leever.state ~= 'none' then
            leever.currentAnimation:draw(sprites.leeverSheet, leever.x-8, leever.y-8)
        end
    end
end

function leeverNewPosition(index)
    local leever = leevers[index]
    local x = Player.x 
    local y = Player.y

    leever.vectorX = 0
    leever.vectorY = 0

    if Player.direction == 'up' then
        y = y - 40
        leever.vectorY = 1

    elseif Player.direction == 'left' then
        x = x - 40
        leever.vectorX = 1
        
    elseif Player.direction == 'down' then
        y = y + 40
        leever.vectorY = -1

    elseif Player.direction == 'right' then
        x = x + 40
        leever.vectorX = -1
    end
    
    if (x > 16 and x < 256) and (y > 72 and y < 224) then

        if checkLayer('Ground_layer', map:convertPixelToTile(x+12, y+12)) == 'sand' then
            leever.x = x
            leever.y = y
            if leever.colliderExists then
                leever.collider:setPosition(x, y)
            end
            leever.hasPosition = true
        else
            leeverAttackBack(index, x, y)
        end
    else
        leeverAttackBack(index, x, y)
    end
end

function leeverEmerge(index, dt)

    local leever = leevers[index]

    if leever.hasPosition == false then
        leeverNewPosition(index)
        if leever.hasPosition == false then
            return
        end
    end

    if leever.colliderExists == false then
        leever.collider = world:newRectangleCollider(leever.x-8, leever.y, 14, 14)
        leever.collider:setCollisionClass('Enemy')
        leever.collider:setFixedRotation(true)
        leever.colliderExists = true
    end

    leever.emergeTimer = leever.emergeTimer + 1 * dt
    
    if leever.emergeTimer <= 0.250 then
        leever.currentAnimation = leever.groundAnimation

    elseif leever.emergeTimer <= 0.400 then
        leever.currentAnimation = leever.emergingAnimation

    elseif leever.emergeTimer >= 0.433 then
        leever.currentAnimation = leever.walkingAnimation
        leever.state = 'attacking'
    end
    
end

function leeverAttacking(index, dt)
    local leever = leevers[index]

    leever.currentAnimation:update(dt)

    if leever.colliderExists == true then
        leever.collider:setLinearVelocity(leever.vectorX * leever.speed, leever.vectorY * leever.speed)
    end
    
    if leever.collider:enter('Wall') then
        leever.state = 'dipping'
        leever.vectorX = 0
        leever.vectorY = 0
    end

end

function leeverDipping(index, dt)
    local leever = leevers[index]
    leever.hasPosition = false
    leever.currentAnimation:update(dt)

    if leever.colliderExists == true then
        leever.collider:destroy()
        leever.colliderExists = false
    end
    leever.dippingTimer = leever.dippingTimer + 1 * dt
    if leever.dippingTimer <= 0.117 then
        leever.currentAnimation = leever.emergingAnimation

    elseif leever.dippingTimer <= 0.383 then
        leever.currentAnimation = leever.groundAnimation
    end

    if leever.dippingTimer >= 0.400 then
        leever.hasPosition = false
        leever.state = 'emerge'
        leever.dippingTimer = 0
        leever.emergeTimer = 0
    end

end

function checkIfHitPlayer(index)
    local leever = leevers[index]

    if leever.colliderExists == true then
        if leever.collider:enter('Player') then
            playerDamage(leever.damage)
            leever.vectorX = invertNumber(leever.vectorX)
            leever.vectorY = invertNumber(leever.vectorY)
        end
    end
end

function checkIfReceiveDamage(index)
    local leever = leevers[index]

    if leever.collider:enter('Weapon') then
        leever.health = leever.health - Sword.damage
    end
end

function leeverDrop(drops)
    if math.random(10) == 1 then
        local item_drop = drops[math.random(#drops)]
        return item_drop
    end
    return 0
end


function leeverAttackBack(index, x, y)
    local leever = leevers[index]
    leever.vectorX = 0
    leever.vectorY = 0

    if Player.direction == 'up' then 
        y = y + 80
        leever.vectorY = -1
    elseif Player.direction == 'down' then
        y = y - 80
        leever.vectorY = 1
    elseif Player.direction == 'left' then 
        x = x + 80
        leever.vectorX = -1
    elseif Player.direction == 'right' then
        x = x - 80
        leever.vectorX = 1
    end
    
    if (x > 16 and x < 256) and (y > 72 and y < 224) then
        if checkLayer('Ground_layer', map:convertPixelToTile(x+12, y+12)) == 'sand' then
            leever.x = x
            leever.y = y
            if leever.colliderExists then
                leever.collider:setPosition(x, y)
            end
            leever.hasPosition = true
            return
        end
    end
    leever.state = 'none'
    leever.emergeTimer = 0

    local spawnTime = 0.1
    for i, lv in ipairs(leevers) do
        spawnTime = spawnTime + 0.5
    end
    leever.initializeTimer = spawnTime

    if leever.colliderExists == true then
        leever.collider:destroy()
        leever.colliderExists = false
    end
end

function deleteLeevers()
    for i, leever in ipairs(leevers) do
        if leever.colliderExists == true then
            leever.collider:destroy()
            leever.colliderExists = false
        end
        table.remove(leevers, i)
    end
end
