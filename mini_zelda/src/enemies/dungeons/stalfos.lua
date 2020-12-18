stalfos = {}

function spawnStalfo()
    local stalfo = {}

    repeat
        stalfo.x = multiple16(love.math.random(16,256))
        stalfo.y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(stalfo.x-8, stalfo.y-8)) == 'dungeon_brick'

    stalfo.vectorX = 0
    stalfo.vectorY = 0

    stalfo.speed = 40
    stalfo.health = 2
    stalfo.damage = 0.5
    stalfo.invincible = false
    stalfo.state = 'idle'

    stalfo.directions = {'up', 'down', 'left', 'right'}
    stalfo.direction = stalfo.directions[math.random(#stalfo.directions)]

    stalfo.grid = anim8.newGrid(16, 16, sprites.stalfo:getWidth(), sprites.stalfo:getHeight())
    stalfo.animation = anim8.newAnimation(stalfo.grid('1-2', 1), 0.2)

    stalfo.collider = world:newRectangleCollider(stalfo.x-14, stalfo.y-6, 12, 12)
    stalfo.collider:setCollisionClass('Enemy')
    stalfo.collider:setFixedRotation(true)
    stalfo.colliderExists = true

    stalfo.pushedDirection = 'none'
    stalfo.turnTimer = 0
    stalfo.pushedTimer = 0
    stalfo.invincibleTimer = 0

    table.insert(stalfos, stalfo)
end

function stalfos:update(dt)
    for i, stalfo in ipairs(stalfos) do

        if stalfo.health <= 0 then
            stalfoDeath(i)
            return
        end

        if stalfo.invincible then
            stalfo.invincibleTimer = stalfo.invincibleTimer + 1 * dt
            if stalfo.invincibleTimer >= 0.750 then
                stalfo.invincible = false
            end
        end

        checkStalfoDamage(i)
        checkIfStalfoDamagePlayer(i)

        stalfo.animation:update(dt)
        stalfo.x, stalfo.y = stalfo.collider:getPosition()

        stalfo.vectorX = 0
        stalfo.vectorY = 0

        if stalfo.collider:enter('Wall') then
            local directions = checkArea(stalfo.x, stalfo.y)
            stalfo.direction = directions[math.random(#directions)]
            stalfo.collider:setPosition(multiple16(stalfo.x+2)+8, multiple16(stalfo.y+2))
            stalfo.turnTimer = 1
        end
        
        if stalfo.state == 'idle' then

            stalfo.turnTimer = stalfo.turnTimer + 1 * dt
            if stalfo.turnTimer >= 2 then
                if math.random(2) == 1 then
                    stalfo.turn = true
                end
            end

            if stalfo.turn then
                if distanceFrom(stalfo.x, stalfo.y, multiple16(stalfo.x)+8, multiple16(stalfo.y+4)) < 1 then
                    local directions = checkArea(stalfo.x, stalfo.y)
                    stalfo.direction = directions[math.random(#directions)]
                    stalfo.collider:setPosition(multiple16(stalfo.x)+8, multiple16(stalfo.y+4))
                    stalfo.turnTimer = 0
                    stalfo.turn = false
                end
            end

            if stalfo.direction == 'up' then
                stalfo.vectorY = -1

            elseif stalfo.direction == 'down' then
                stalfo.vectorY = 1

            elseif stalfo.direction == 'left' then
                stalfo.vectorX = -1
                
            elseif stalfo.direction == 'right' then
                stalfo.vectorX = 1
            end

            stalfo.collider:setLinearVelocity(stalfo.vectorX * stalfo.speed, stalfo.vectorY * stalfo.speed)

        elseif stalfo.state == 'pushed' then
            stalfo.pushedTimer = stalfo.pushedTimer + 1 * dt
            stalfo.x, stalfo.y = stalfo.collider:getPosition()
            local x, y = (getDirectionVector(stalfo.pushedDirection) * dt * 600):unpack()
            stalfo.collider:setLinearVelocity(x * stalfo.speed, y * stalfo.speed)

            if stalfo.pushedTimer >= 0.133 then
                stalfo.state = 'idle'
            end
        end
    end
end

function stalfos:draw()
    for i, stalfo in ipairs(stalfos) do
        if stalfo.invincible == true then
            -- makes the sprite blink white
            if math.floor(math.cos(love.timer.getTime() * 18 % 2 * math.pi)) == 0 then
                love.graphics.setShader(white_flash)
            end
        else
            love.graphics.setShader()
        end
        stalfo.animation:draw(sprites.stalfo, stalfo.x-8, stalfo.y-8)
    end
end

function checkStalfoDamage(index)
    local stalfo = stalfos[index]

    if stalfo.invincible then return end

    if stalfo.collider:enter('Weapon') then

        local sword
        for i, swordT in ipairs(swordThrow) do
            sword = swordT
        end

        stalfo.health = stalfo.health - Sword.damage
        stalfo.invincible = true
        stalfo.invincibleTimer = 0
        stalfo.state = 'pushed'
        if sword == nil then
            stalfo.pushedDirection = Sword.direction
        else
            stalfo.pushedDirection = sword.direction
        end
        if stalfo.health >= 1 then
            sounds.enemyHit:stop()
            sounds.enemyHit:play()
        end

    elseif stalfo.collider:enter('Arrow') then
        stalfo.health = stalfo.health - arrows[1].damage
        stalfo.invincible = true
        stalfo.invincibleTimer = 0
        stalfo.state = 'pushed'
        stalfo.pushedDirection = arrows[1].direction

        if stalfo.health >= 1 then
            sounds.enemyHit:stop()
            sounds.enemyHit:play()
        end
    end
end

function checkIfStalfoDamagePlayer(index)
    local stalfo = stalfos[index]

    if stalfo.collider:enter('Player') then
        playerDamage(stalfo.damage)
    end
end

function stalfoDeath(index)
    local stalfo = stalfos[index]

    deathSpawn(stalfo.x-8, stalfo.y-8, enemyDrops())
    enemiesDungeon1_rooms[currentDungeonRoom][3] = enemiesDungeon1_rooms[currentDungeonRoom][3] - 1

    if stalfo.colliderExists then
        stalfo.collider:destroy()
        stalfo.colliderExists = false
    end

    table.remove(stalfos, index)
end

function deleteStalfos()
    for i, stalfo in ipairs(stalfos) do

        if stalfo.colliderExists then
            stalfo.collider:destroy()
            stalfo.colliderExists = false
        end

        table.remove(stalfos, i)
    end
end
