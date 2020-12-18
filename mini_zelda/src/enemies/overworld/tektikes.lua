tektikes = {}

function spawnTektike(type)
    local tektike = {}

    tektike.type = type
    tektike.health = 1
    tektike.state = 'floor'
    tektike.jumpTimer = love.math.random(0.3, 3)

    tektike.jump = false
    tektike.haveTarget = false

    repeat
        tektike.x = multiple16(love.math.random(16,256))
        tektike.y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(tektike.x-8, tektike.y-8)) == 'sand'

    tektike.dx = 0
    tektike.dy = 0

    tektike.targetX = 0
    tektike.targetY = 0

    tektike.sprite = sprites.tektikeSheet
    tektike.grid = anim8.newGrid(16, 16, tektike.sprite:getWidth(), tektike.sprite:getHeight())

    if tektike.type == 'red' then
        tektike.idleAnimation = anim8.newAnimation(tektike.grid('1-2', 1), 0.3)
        tektike.floor = anim8.newAnimation(tektike.grid(1, 1), 1)
        tektike.jumping = anim8.newAnimation(tektike.grid(2, 1), 1)
    elseif tektike.type == 'blue' then
        tektike.idleAnimation = anim8.newAnimation(tektike.grid('1-2', 2), 0.3)
        tektike.floor = anim8.newAnimation(tektike.grid(1, 2), 1)
        tektike.jumping = anim8.newAnimation(tektike.grid(2, 2), 1)
    end

    tektike.currentAnimation = tektike.floor

    tektike.collider = world:newRectangleCollider(tektike.x-16, tektike.y-8, 16, 16)
    tektike.collider:setCollisionClass('Enemy')
    tektike.collider:setFixedRotation(true)
    
    tektike.colliderExists = true

    table.insert(tektikes, tektike)
end

function tektikes:update(dt)
    for i, tektike in ipairs(tektikes) do

        if tektike.health > 0 then 
            tektikeCheckDamage(i)
            tektikeCheckDamagePlayer(i)

            tektike.collider:setPosition(tektike.x, tektike.y)
            if tektike.state == 'floor' then
                tektike.jumpTimer = tektike.jumpTimer - 1 * dt
                tektike.jump = false
            end

            if tektike.state == 'jumping' then
                if tektike.haveTarget == false then
                    tektike.targetX, tektike.targetY = tektikeJumpTarget(i)
                    tektike.haveTarget = true
                end

                if tektike.jump == false then
                    if tektike.y >= tektikeTmpY then
                        tektike.y = tektike.y - 4
                    else
                        tektike.jump = true
                    end
                end

                tektike.dx, tektike.dy = checkDistance(tektike.targetX, tektike.targetY, 
                    tektike.x, tektike.y)

                tektike.x = tektike.x + tektike.dx * dt * 10
                if tektike.jump == true then
                    tektike.y = tektike.y + tektike.dy * dt * 16
                end

                if distanceFrom(tektike.targetX, tektike.targetY, tektike.x, tektike.y) <= 5 then
                    tektike.haveTarget = false
                    tektike.jumpTimer = love.math.random(0.3, 3)
                    tektike.state = 'floor'
                end

            end

            if tektike.jumpTimer <= 0.8 and tektike.state == 'floor' then
                tektike.currentAnimation = tektike.floor
            elseif tektike.state == 'floor' then
                tektike.currentAnimation = tektike.idleAnimation
                tektike.currentAnimation:update(dt)
            end

            if tektike.jumpTimer <= 0 and tektike.state ~= 'jumping' then 
                tektike.state = 'jumping'
                tektike.currentAnimation = tektike.jumping
                tektikeTmpY = tektike.y - 16
            end
        else
            if tektike.type == 'red' then
                enemies_room[currentOverworldRoom][4] = enemies_room[currentOverworldRoom][4] - 1 
            elseif tektike.type == 'blue' then
                enemies_room[currentOverworldRoom][5] = enemies_room[currentOverworldRoom][5] - 1 
            end
            deathSpawn(tektike.x-8, tektike.y-8, enemyDrops())
            tektikeDeath(i)
        end
    end
end

function tektikes:draw()
    for i, tektike in ipairs(tektikes) do
        tektike.currentAnimation:draw(tektike.sprite, tektike.x-8, tektike.y-8)
    end
end

function tektikeCheckDamage(index)
    if tektikes[index].collider:enter('Weapon') or tektikes[index].collider:enter('Arrow') then
        tektikes[index].health = tektikes[index].health - Sword.damage
        if tektikes[index].health >= 1 then
            sounds.enemyHit:stop()
            sounds.enemyHit:play()
        end
    end
end

function tektikeCheckDamagePlayer(index)
    if tektikes[index].collider:enter('Player') then
        playerDamage(0.5)
    end
end

function tektikeDeath(index)
    if tektikes[index].colliderExists == true then
        tektikes[index].collider:destroy()
        tektikes[index].colliderExists = false
    end
    table.remove(tektikes, index)
end

function deleteTektikes()
    for i, tektike in ipairs(tektikes) do
        if tektike.colliderExists == true then
            tektike.collider:destroy()
            tektike.colliderExists = false
        end
        table.remove(tektikes, i)
    end
end

function tektikeJumpTarget(index)
    local x
    local y

    repeat
        x = tektikes[index].x + love.math.random(-32, 32)
        y = tektikes[index].y + love.math.random(-32, 32)
    until (x >= 16 and x <= 256) and (y >= 72 and y <= 224)

    return x, y
end
