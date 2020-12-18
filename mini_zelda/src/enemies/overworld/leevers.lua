leevers = {}

function spawnLeever(type)

    local leever = {}
    
    leever.type = type

    local x, y
    repeat
        x = multiple16(love.math.random(16,256))
        y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(x-8, y-8)) == 'sand'

    leever.x = x
    leever.y = y

    leever.vectorX = 0
    leever.vectorY = 0

    leever.hasPosition = false
    leever.state = 'none'
    leever.attackingDirection = 'none'
    leever.directions = {'up', 'down', 'left', 'right'}
    leever.direction = leever.directions[math.random(#leever.directions)]
    leever.invincible = false
    leever.check = false

    leever.speed = 40

    leever.grid = anim8.newGrid(16, 16, sprites.leeverSheet:getWidth(), sprites.leeverSheet:getHeight())
    leever.groundAnimation = anim8.newAnimation(leever.grid('1-2', 1), 0.117)
    leever.currentAnimation = leever.groundAnimation

    if leever.type == 'red' then
        leever.emergingAnimation = anim8.newAnimation(leever.grid(1, 2), 2)
        leever.walkingAnimation = anim8.newAnimation(leever.grid('2-3', 2), 0.1)
        leever.damage = 0.5
        leever.health = 2
    elseif leever.type == 'blue' then
        leever.emergingAnimation = anim8.newAnimation(leever.grid(1, 3), 2)
        leever.walkingAnimation = anim8.newAnimation(leever.grid('2-3', 3), 0.1)

        leever.damage = 1
        leever.health = 4
    end

    leever.colliderExists = false
    leever.colliderFrontExists = false

    leever.pushedDirection = 'none'

    leever.emergeTimer = 0
    leever.walkingTimer = 0
    leever.dippingTimer = 0
    leever.invincibleTimer = 0
    leever.pushedTimer = 0

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

                if leever.invincible == true then
                    leever.invincibleTimer = leever.invincibleTimer + 1 * dt
                    if leever.invincibleTimer >= 0.750 then
                        leever.invincibleTimer = 0
                        leever.invincible = false
                    end
                end

                if leever.state == 'pushed' then

                    leever.x, leever.y = leever.collider:getPosition()

                    local x, y = (getDirectionVector(leever.pushedDirection) * 600 * dt):unpack()
                    leever.collider:setLinearVelocity(x * leever.speed, y * leever.speed)

                    leever.pushedTimer = leever.pushedTimer + 1 * dt
                    if leever.pushedTimer >= 0.133 then
                        leever.state = leever.stateTmp
                    end
                end

                if leever.type == 'red' then

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

                elseif leever.type == 'blue' then

                    if leever.emergeTimer <= 0.533 then
                        leever.state = 'emerge'
                    end

                    if leever.state == 'emerge' then
                        leeverEmerge(i, dt)
                    end

                    if leever.state == 'walking' then
                        leeverWalking(i, dt)
                    end

                    if leever.state == 'dipping' then
                        leeverDipping(i, dt)
                    end

                    if leever.colliderExists == true then
                        leever.x, leever.y = leever.collider:getPosition()
                        checkIfReceiveDamage(i)
                        checkIfHitPlayer(i)
                    end

                    leever.vectorX = 0
                    leever.vectorY = 0

                    if leever.direction == 'up' then
                        leever.vectorY = -1
                        if leever.colliderFrontExists then
                            leever.colliderFront:setPosition(leever.x, leever.y-6)
                        end
                    elseif leever.direction == 'left' then
                        leever.vectorX = -1
                        if leever.colliderFrontExists then
                            leever.colliderFront:setPosition(leever.x-6, leever.y)
                        end
                    elseif leever.direction == 'down' then
                        leever.vectorY = 1
                        if leever.colliderFrontExists then
                            leever.colliderFront:setPosition(leever.x, leever.y+6)
                        end
                    elseif leever.direction == 'right' then
                        leever.vectorX = 1
                        if leever.colliderFrontExists then
                            leever.colliderFront:setPosition(leever.x+6, leever.y)
                        end
                    end

                    leever.emergeTimer = leever.emergeTimer + 1 * dt
                end
            else
                leever.initializeTimer = leever.initializeTimer - 1 * dt
            end
        else
            if leever.colliderExists then
                leever.collider:destroy()
                if leever.colliderFrontExists then
                    leever.colliderFront:destroy()
                end
                leever.colliderExists = false
                leever.colliderFrontExists = false
            end
            
            if leever.type == 'red' then
                enemies_room[currentOverworldRoom][6] = enemies_room[currentOverworldRoom][6] - 1 
            elseif leever.type == 'blue' then
                enemies_room[currentOverworldRoom][7] = enemies_room[currentOverworldRoom][7] - 1 
            end

            deathSpawn(leever.x-8, leever.y-8, enemyDrops())
            table.remove(leevers, i)
        end
    end
end

function leevers:draw()
    for i, leever in ipairs(leevers) do
        if leever.invincible == true then
            if math.floor(math.cos(love.timer.getTime() * 18 % 2 * math.pi)) == 0 then
                love.graphics.setShader(white_flash)
            end
        end
        if leever.state ~= 'none' then
            leever.currentAnimation:draw(sprites.leeverSheet, leever.x-8, leever.y-8)
        end
        love.graphics.setShader()
    end
end

function leeverNewPosition(index)
    local leever = leevers[index]

    if leever.type == 'red' then
        local x = Player.x 
        local y = Player.y

        if Player.direction == 'up' then
            y = y - 40
            leever.direction = 'down'

        elseif Player.direction == 'left' then
            x = x - 40
            leever.direction = 'right'
            
        elseif Player.direction == 'down' then
            y = y + 40
            leever.direction = 'up'

        elseif Player.direction == 'right' then
            x = x + 40
            leever.direction = 'left'

        end
        
        if (x > 32 and x < 240) and (y > 72 and y < 208) then

            if checkLayer('Ground_layer', map:convertPixelToTile(x-8, y-8)) == 'sand' then
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

    elseif leever.type == 'blue' then

        repeat
            x = multiple16(love.math.random(16,256))
            y = multiple16(love.math.random(72,224))
        until checkLayer('Ground_layer', map:convertPixelToTile(x-8, y-8)) == 'sand'

        leever.x = x
        leever.y = y

        local directions = checkArea(leever.x+8, leever.y)
        leever.direction = directions[math.random(#directions)]

        leever.hasPosition = true
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

    if leever.type == 'red' then
        
        if leever.emergeTimer <= 0.250 then
            leever.currentAnimation = leever.groundAnimation

        elseif leever.emergeTimer <= 0.400 then
            leever.currentAnimation = leever.emergingAnimation

        elseif leever.emergeTimer >= 0.433 then
            leever.currentAnimation = leever.walkingAnimation
            leever.state = 'attacking'
        end

        leever.emergeTimer = leever.emergeTimer + 1 * dt

    elseif leever.type == 'blue' then

        if leever.emergeTimer < 0.533 then
            leever.currentAnimation = leever.groundAnimation
            leever.currentAnimation:update(dt)
            
        elseif leever.emergeTimer >= 0.533 and leever.emergeTimer < 0.800 then
            leever.currentAnimation = leever.emergingAnimation

        elseif leever.emergeTimer >= 0.800 then
            leever.currentAnimation = leever.walkingAnimation
            leever.state = 'walking'
        end

        if leever.colliderFrontExists == false then
            leever.colliderFront = world:newRectangleCollider(leever.x, leever.y, 4, 4)
            leever.colliderFront:setCollisionClass('EnemyCollider')
            leever.colliderFront:setFixedRotation(true)
            leever.colliderFrontExists = true
        end
    end

    if leever.colliderExists == false then
        leever.collider = world:newRectangleCollider(leever.x+1, leever.y-7, 14, 14)
        leever.collider:setCollisionClass('Enemy')
        leever.collider:setFixedRotation(true)
        leever.colliderExists = true
    end
    
end

function leeverWalking(index, dt)
    local leever = leevers[index]

    leever.currentAnimation:update(dt)

    if leever.colliderExists == true and leever.colliderFrontExists == true then
        leever.collider:setLinearVelocity(leever.vectorX * leever.speed, leever.vectorY * leever.speed)
        leever.colliderFront:setLinearVelocity(leever.vectorX * leever.speed, leever.vectorY * leever.speed)
    end
    
    if leever.emergeTimer <= 5.033 then
        leever.currentAnimation = leever.walkingAnimation

    elseif leever.emergeTimer >= 5.033 then
        leever.state = 'dipping'
    end

    leever.walkingTimer = leever.walkingTimer + 1 * dt

    if leever.colliderFront:enter('Wall') then
        local directions = checkArea(leever.x, leever.y)
        leever.direction = directions[math.random(#directions)]
    end
end

function leeverAttacking(index, dt)

    local leever = leevers[index]

    leever.currentAnimation:update(dt)

    leever.vectorX = 0
    leever.vectorY = 0

    if leever.direction == 'up' then
        leever.vectorY = -1
    elseif leever.direction == 'left' then
        leever.vectorX = -1
    elseif leever.direction == 'down' then
        leever.vectorY = 1
    elseif leever.direction == 'right' then
        leever.vectorX = 1
    end

    if leever.colliderExists == true then
        leever.collider:setLinearVelocity(leever.vectorX * leever.speed, leever.vectorY * leever.speed)
    end
    
    if leever.collider:enter('Wall') or leever.collider:enter('stay') then
        leever.state = 'dipping'
    end

    if leever.x < 32 or leever.x > 240 or leever.y < 72 or leever.y > 208 then
        leever.state = 'dipping'
    end

end

function leeverDipping(index, dt)

    local leever = leevers[index]
    leever.hasPosition = false
    leever.currentAnimation:update(dt)

    if leever.colliderExists == true then
        leever.collider:destroy()
        if leever.colliderFrontExists then
            leever.colliderFront:destroy()
        end
        leever.colliderExists = false
        leever.colliderFrontExists = false
    end
    leever.dippingTimer = leever.dippingTimer + 1 * dt
    if leever.dippingTimer <= 0.117 then
        leever.currentAnimation = leever.emergingAnimation

    elseif leever.dippingTimer <= 0.383 then
        leever.currentAnimation = leever.groundAnimation
    end

    if leever.dippingTimer >= 0.400 then
        leever.hasPosition = false
        leever.check = false
        leever.state = 'emerge'
        leever.dippingTimer = 0
        leever.walkingTimer = 0
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
    if leever.invincible then return end
    
    if leever.collider:enter('Weapon') then

        local sword
        for i, swordT in ipairs(swordThrow) do
            sword = swordT
        end

        leever.health = leever.health - Sword.damage
        leever.invincible = true
        leever.stateTmp = leever.state
        leever.state = 'pushed'
        if sword == nil then
            leever.pushedDirection = Sword.direction
        else
            leever.pushedDirection = sword.direction
        end
        
        leever.pushedTimer = 0

    elseif leever.collider:enter('Arrow') then
        leever.health = leever.health - arrows[1].damage
        leever.invincible = true
        leever.stateTmp = leever.state
        leever.state = 'pushed'
        leever.pushedDirection = arrows[1].direction
        leever.pushedTimer = 0
    end
end

function leeverAttackBack(index, x, y)
    local leever = leevers[index]

    if Player.direction == 'up' then 
        y = y + 80
        leever.direction = Player.direction

    elseif Player.direction == 'down' then
        y = y - 80
        leever.direction = Player.direction

    elseif Player.direction == 'left' then 
        x = x + 80
        leever.direction = Player.direction

    elseif Player.direction == 'right' then
        x = x - 80
        leever.direction = Player.direction
    end
    
    if (x > 32 and x < 240) and (y > 72 and y < 208) then
        if checkLayer('Ground_layer', map:convertPixelToTile(x-8, y-8)) == 'sand' then
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
            if leever.colliderFrontExists then
                leever.colliderFront:destroy()
                leever.colliderFrontExists = false
            end
            leever.colliderExists = false
        end
        table.remove(leevers, i)
    end
end
