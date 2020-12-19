keeses = {}

function spawnKeese()
    local keese = {}

    repeat
        keese.x = multiple16(love.math.random(16,256))
        keese.y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(keese.x-8, keese.y-8)) == 'dungeon_brick'

    repeat
        keese.vectorX = math.random(-1, 1)
        keese.vectorY = math.random(-1, 1)
    until keese.vectorX ~= 0 or keese.vectorY ~= 0

    keese.state = 'taking off'
    keese.speed = 0
    keese.health = 1
    keese.damage = 0.5

    keese.grid = anim8.newGrid(16, 16, sprites.keese:getWidth(), sprites.keese:getHeight())
    keese.animation = anim8.newAnimation(keese.grid('1-2', 1), 0.1)

    keese.collider = world:newRectangleCollider(keese.x-16, keese.y-8, 14, 10)
    keese.collider:setCollisionClass('IgnoreWallEnemy')
    keese.collider:setFixedRotation(true)
    keese.colliderExists = true

    keese.idleTimer = 0
    keese.timer = 0
    keese.landedTime = math.random() + math.random(0.5, 1)

    keese.timerAnimation = 0

    table.insert(keeses, keese)
end

function keeses:update(dt)
    for i, keese in ipairs(keeses) do

        if keese.health <= 0 then
            deathSpawn(keese.x-8, keese.y-8, 0)
            removeKeese(i)
            return
        end

        checkIfKeeseDamagePlayer(i)
        checkIfPlayerDamageKeese(i)

        -- check if the keese is on the limits of the walls
        if keese.x < 32 then
            keese.vectorX = 1
        elseif keese.x > 224 then
            keese.vectorX = -1
        end

        if keese.y < 88 then
            keese.vectorY = 1    
        elseif keese.y > 200 then
            keese.vectorY = -1
        end
        
        keese.x, keese.y = keese.collider:getPosition()

        keese.timer = keese.timer + 1 * dt
        if keese.state == 'idle' then
            keese.animation:update(dt)
            keese.idleTimer = keese.idleTimer + 1 * dt
            if keese.idleTimer >= 1 then
                repeat
                    keese.vectorX = math.random(-1, 1)
                    keese.vectorY = math.random(-1, 1)
                until keese.vectorX ~= 0 or keese.vectorY ~= 0
                keese.idleTimer = 0

                if math.random(20) == 1 then
                    local distanceX, distanceY = checkDistance(keese.x, keese.y, Player.x, Player.y)
    
                    if distanceX < 0 and distanceY < 0 then
                        keese.vectorX = 1
                    elseif distanceX > 0 and distanceY < 0 then
                        keese.vectorY = 1
                    end
                    if distanceY > 0 and distanceX < 0 then
                        keese.vectorY = -1
                    elseif distanceY > 0 and distanceX > 0 then
                        keese.vectorX = -1
                    end
                end
            end

            if keese.timer > 5 then
                if math.random(3) == 1 then
                    keese.state = 'landing'
                    keese.timer = 0
                else
                    keese.timer = 0
                end
            end
        end

        if keese.state == 'landing' then
            if keese.speed > 0 then
                keese.speed = keese.speed - 28 * dt
            else
                keese.speed = 0
            end

            if keese.timerAnimation > 0 then
                keese.timerAnimation = keese.timerAnimation- 0.5 * dt
            else
                keese.timerAnimation = 0
            end

            keese.animation:update(dt * keese.timerAnimation)
            if keese.timer >= 1.650 then
                keese.state = 'landed'
                keese.timer = 0
                keese.landedTime = math.random() + math.random(0.5, 1)
            end
        end

        if keese.state == 'landed' then
            if keese.timer >= keese.landedTime then
                keese.state = 'taking off'
                keese.timer = 0
            end
        end

        if keese.state == 'taking off' then
            if keese.speed < 40 then
                keese.speed = keese.speed + 28 * dt
            else
                keese.speed = 40
            end

            if keese.timerAnimation < 1 then
                keese.timerAnimation = keese.timerAnimation + 0.5 * dt
            else
                keese.timerAnimation = 1
            end

            keese.animation:update(dt * keese.timerAnimation)

            if keese.timer >= 1.650 then
                keese.state = 'idle'
                keese.timer = 0
                keese.timeAnimation = 1
                keese.speed = 40
            end
        end

        keese.collider:setLinearVelocity(keese.vectorX * keese.speed, keese.vectorY * keese.speed)
    end
end

function keeses:draw()
    for i, keese in ipairs(keeses) do
        keese.animation:draw(sprites.keese, keese.x-8, keese.y-8)
    end
end

function checkIfPlayerDamageKeese(index)
    local keese = keeses[index]
    if keese.collider:enter('Weapon') or keese.collider:enter('Arrow') then
        keese.health = keese.health - Sword.damage
    end
end

function checkIfKeeseDamagePlayer(index)
    local keese = keeses[index]
    if keese.collider:enter('Player') then
        playerDamage(keese.damage)
    end
end

function removeKeese(index)
    local keese = keeses[index]
    if keese.colliderExists then
        keese.collider:destroy()
        keese.colliderExists = false
    end
    enemiesDungeon1_rooms[currentDungeonRoom][1] = enemiesDungeon1_rooms[currentDungeonRoom][1] - 1
    table.remove(keeses, index)
end

function deleteKeeses()
    for i, keese in ipairs(keeses) do
        if keese.colliderExists then
            keese.collider:destroy()
            keese.colliderExists = false
        end
        table.remove(keeses, i)
    end
end
