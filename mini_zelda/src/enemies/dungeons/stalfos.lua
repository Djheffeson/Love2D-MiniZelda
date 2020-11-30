stalfos = {}

function spawnStalfo()
    local stalfo = {}

    repeat
        stalfo.x = multiple16(love.math.random(16,256))
        stalfo.y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(stalfo.x+12, stalfo.y+12)) == 'dungeon_brick'

    stalfo.vectorX = 0
    stalfo.vectorY = 0

    stalfo.speed = 40
    stalfo.health = 2
    stalfo.damage = 0.5
    stalfo.invincible = false
    stalfo.state = 'idle'
    stalfo.drops = {1,3}

    stalfo.directions = {'up', 'down', 'left', 'right'}
    stalfo.direction = stalfo.directions[math.random(#stalfo.directions)]

    stalfo.grid = anim8.newGrid(16, 16, sprites.stalfo:getWidth(), sprites.stalfo:getHeight())
    stalfo.animation = anim8.newAnimation(stalfo.grid('1-2', 1), 0.2)

    stalfo.collider = world:newRectangleCollider(stalfo.x-14, stalfo.y-6, 12, 12)
    stalfo.collider:setCollisionClass('Enemy')
    stalfo.collider:setFixedRotation(true)
    stalfo.colliderExists = true

    stalfo.colliderFront = world:newRectangleCollider(stalfo.x, stalfo.y, 4, 4)
    stalfo.colliderFront:setCollisionClass('EnemyCollider')
    stalfo.colliderFront:setFixedRotation(true)
    stalfo.colliderFrontExists = true

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

        if stalfo.colliderFront:enter('Wall') then
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
                stalfo.colliderFront:setPosition(stalfo.x, stalfo.y-6)

            elseif stalfo.direction == 'down' then
                stalfo.vectorY = 1
                stalfo.colliderFront:setPosition(stalfo.x, stalfo.y+6)

            elseif stalfo.direction == 'left' then
                stalfo.vectorX = -1
                stalfo.colliderFront:setPosition(stalfo.x-6, stalfo.y)
                
            elseif stalfo.direction == 'right' then
                stalfo.vectorX = 1
                stalfo.colliderFront:setPosition(stalfo.x+6, stalfo.y)
            end

            stalfo.collider:setLinearVelocity(stalfo.vectorX * stalfo.speed, stalfo.vectorY * stalfo.speed)
            stalfo.colliderFront:setLinearVelocity(stalfo.vectorX * stalfo.speed, stalfo.vectorY * stalfo.speed)

        elseif stalfo.state == 'pushed' then
            stalfo.pushedTimer = stalfo.pushedTimer + 1 * dt

            stalfo.x, stalfo.y = stalfo.collider:getPosition()
            local x, y = (getDirectionVector(Player.direction) * dt * 600):unpack()
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
            love.graphics.setColor(1, 0, 0, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        stalfo.animation:draw(sprites.stalfo, stalfo.x-8, stalfo.y-8)
    end
end

function checkStalfoDamage(index)
    local stalfo = stalfos[index]

    if stalfo.collider:enter('Weapon') and stalfo.invincible == false then
        stalfo.health = stalfo.health - Sword.damage
        stalfo.invincible = true
        stalfo.invincibleTimer = 0
        stalfo.state = 'pushed'
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

    deathSpawn(stalfo.x-8, stalfo.y-8, stalfoDrop(stalfo.drops))
    enemiesDungeon1_rooms[currentDungeonRoom][3] = enemiesDungeon1_rooms[currentDungeonRoom][3] - 1

    if stalfo.colliderExists then
        stalfo.collider:destroy()
        stalfo.colliderExists = false
    end
    if stalfo.colliderFrontExists then
        stalfo.colliderFront:destroy()
        stalfo.colliderFrontExists = false
    end

    table.remove(stalfos, index)
end

function stalfoDrop(drops)
    if math.random(10) == 1 then
        local item_drop = drops[math.random(#drops)]
        return item_drop
    end
    return 0
end

function deleteStalfos()
    for i, stalfo in ipairs(stalfos) do

        if stalfo.colliderExists then
            stalfo.collider:destroy()
            stalfo.colliderExists = false
        end
        if stalfo.colliderFrontExists then
            stalfo.colliderFront:destroy()
            stalfo.colliderFrontExists = false
        end

        table.remove(stalfos, i)
    end
end
