peahats = {}

function spawnPeahat()

    local peahat = {}

    local x, y
    repeat
        x = multiple16(love.math.random(16,256))
        y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(x-8, y-8)) == 'sand'

    peahat.x = x
    peahat.y = y

    peahat.vectorX = 0
    peahat.vectorY = -1

    peahat.state = 'taking off'
    peahat.speed = 0
    peahat.damage = 0.5
    peahat.health = 1

    peahat.sprite = sprites.peahatSheet
    peahat.grid = anim8.newGrid(16, 16, peahat.sprite:getWidth(), peahat.sprite:getHeight())
    peahat.animation = anim8.newAnimation(peahat.grid('1-2', 1), 0.033)

    peahat.collider = world:newRectangleCollider(peahat.x-16, peahat.y-8, 16, 16)
    peahat.collider:setCollisionClass('IgnoreAll')
    peahat.collider:setFixedRotation(true)
    peahat.colliderExists = true

    peahat.idleTimer = 0
    peahat.timer = 0

    peahat.timeAnimation = 0
    peahat.landedTime = math.random() + math.random(0.5, 1)

    table.insert(peahats, peahat)
end

function peahats:update(dt)
    for i, peahat in ipairs(peahats) do

        if peahat.health <= 0 then
            deathSpawn(peahat.x-8, peahat.y-8, enemyDrops())
            removePeahat(i)
            return
        end

        checkIfDamagePlayer(i)
        peahat.x, peahat.y = peahat.collider:getPosition()
        
        -- Check if the peahat is on the limit of the screen
        if peahat.x < 16 then
            peahat.vectorX = 1
        elseif peahat.x > 240 then
            peahat.vectorX = -1
        end

        if peahat.y < 88 then
            peahat.vectorY = 1    
        elseif peahat.y > 208 then
            peahat.vectorY = -1
        end

        peahat.timer = peahat.timer + 1 * dt
        if peahat.state == 'idle' then

            peahat.idleTimer = peahat.idleTimer + 1 * dt
            if peahat.idleTimer >= 1 then
                repeat
                    peahat.vectorX = math.random(-1, 1)
                    peahat.vectorY = math.random(-1, 1)
                until peahat.vectorX ~= 0 or peahat.vectorY ~= 0
                peahat.idleTimer = 0
                
                if math.random(20) == 1 then
                    local distanceX, distanceY = checkDistance(peahat.x, peahat.y, Player.x, Player.y)
    
                    if distanceX < 0 and distanceY < 0 then
                        peahat.vectorX = 1
                    elseif distanceX > 0 and distanceY < 0 then
                        peahat.vectorY = 1
                    end
                    if distanceY > 0 and distanceX < 0 then
                        peahat.vectorY = -1
                    elseif distanceY > 0 and distanceX > 0 then
                        peahat.vectorX = -1
                    end
                end

            end

            if peahat.timer >= 5 then
                if math.random(2) == 1 then
                    peahat.state = 'landing'
                    peahat.timer = 0
                else
                    peahat.timer = 0
                end
            end

            peahat.animation:update(dt)
        end

        if peahat.state == 'landing' then
            
            if peahat.speed > 0 then
                peahat.speed = peahat.speed - 28 * dt
            else
                peahat.speed = 0
            end

            if peahat.timeAnimation > 0 then
                peahat.timeAnimation = peahat.timeAnimation - 0.5 * dt
            else
                peahat.timeAnimation = 0
            end

            peahat.animation:update(dt*peahat.timeAnimation)
            if peahat.timer >= 1.650 then
                peahat.state = 'landed'
                peahat.timer = 0
                peahat.landedTime = math.random() + math.random(0.5, 1)
            end
        end

        if peahat.state == 'landed' then
            checkPeahatDamage(i)
            if peahat.timer >= peahat.landedTime then
                peahat.state = 'taking off'
                peahat.timer = 0
            end
        end

        if peahat.state == 'taking off' then
            if peahat.speed < 40 then
                peahat.speed = peahat.speed + 28 * dt
            else
                peahat.speed = 40
            end

            if peahat.timeAnimation < 1 then
                peahat.timeAnimation = peahat.timeAnimation + 0.5 * dt
            else
                peahat.timeAnimation = 1
            end

            peahat.animation:update(dt*peahat.timeAnimation)
            if peahat.timer >= 1.650 then
                peahat.state = 'idle'
                peahat.timer = 0
                peahat.timeAnimation = 1
                peahat.speed = 40
            end
        end

        peahat.collider:setLinearVelocity(peahat.vectorX * peahat.speed, peahat.vectorY * peahat.speed)
    end
end

function peahats:draw()
    for i, peahat in ipairs(peahats) do
        peahat.animation:draw(peahat.sprite, peahat.x-8, peahat.y-8)
    end
end

function checkPeahatDamage(index)
    local peahat = peahats[index]
    
    if peahat.collider:enter('Weapon') or peahat.collider:enter('Arrow') then
        peahat.health = peahat.health - Sword.damage
    end
end

function checkIfDamagePlayer(index)
    local peahat = peahats[index]
    
    if peahat.collider:enter('Player') then
        playerDamage(peahat.damage)
    end
end

function removePeahat(index)
    local peahat = peahats[index]

    if peahat.colliderExists == true then
        peahat.collider:destroy()
        peahat.colliderExists = false
    end

    enemies_room[currentOverworldRoom][8] = enemies_room[currentOverworldRoom][8] - 1
    table.remove(peahats, index)
end

function deletePeahats()
    for i, peahat in ipairs(peahats) do
        if peahat.colliderExists == true then
            peahat.collider:destroy()
            peahat.colliderExists = false
        end
        table.remove(peahats, i)
    end
end
