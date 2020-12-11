swordThrow = {}

function swordSpawn(x, y, direction)
    local sword = {}

    sword.x = x
    sword.y = y
    sword.speed = 50
    sword.direction = direction
    sword.animation = Sword.currentAnimation
    sword.tmpNum = 0
    sword.collide = false

    sword.grid = anim8.newGrid(16, 16, sprites.woodenSword:getWidth(), sprites.woodenSword:getHeight())
    sword.up = anim8.newAnimation(sword.grid(1, '1-4'), 0.02)
    sword.down = anim8.newAnimation(sword.grid(1, '1-4'), 0.02):flipV()
    sword.left = anim8.newAnimation(sword.grid(2, '1-4'), 0.02):flipH()
    sword.right = anim8.newAnimation(sword.grid(2, '1-4'), 0.02)

    if direction == 'up' then
        sword.animation = sword.up

    elseif direction == 'down' then
        sword.animation = sword.down

    elseif direction == 'left' then
        sword.animation = sword.left

    elseif direction == 'right' then
        sword.animation = sword.right
    end

    sword.particleGrid = anim8.newGrid(8, 10, sprites.swordParticles:getWidth(), sprites.swordParticles:getHeight())
    sword.particleUpLeft = anim8.newAnimation(sword.particleGrid('1-4', 1), 0.02)
    sword.particleDownLeft = anim8.newAnimation(sword.particleGrid('1-4', 1), 0.02):flipV()
    sword.particleUpRight = anim8.newAnimation(sword.particleGrid('1-4', 1), 0.02):flipH()
    sword.particleDownRight = anim8.newAnimation(sword.particleGrid('1-4', 1), 0.02):flipH():flipV()

    if sword.direction == 'up' then
        sword.collider = world:newRectangleCollider(sword.x+1, sword.y+4, 16, 4)
        sword.collider:setAngle(math.pi / 2)
        sword.collider:setFixedRotation(true)
        sword.collider:setCollisionClass('Weapon')
    elseif sword.direction == 'down' then
        sword.collider = world:newRectangleCollider(sword.x+1, sword.y+4, 16, 4)
        sword.collider:setAngle(math.pi / 2)
        sword.collider:setFixedRotation(true)
        sword.collider:setCollisionClass('Weapon')
    elseif sword.direction == 'left' then
        sword.collider = world:newRectangleCollider(sword.x, sword.y+6, 16, 4)
        sword.collider:setFixedRotation(true)
        sword.collider:setCollisionClass('Weapon')
    elseif sword.direction == 'right' then
        sword.collider = world:newRectangleCollider(sword.x, sword.y+6, 16, 4)
        sword.collider:setFixedRotation(true)
        sword.collider:setCollisionClass('Weapon')
    end
    sword.colliderExists = true

    sword.throw = true
    sword.explosion = false
    sword.timerFade = 0
    sword.playSound = true

    table.insert(swordThrow, sword)
end

function swordThrow:update(dt)
    for i, sword in ipairs(swordThrow) do
        
        if sword.playSound == true then
            sounds.swordShoot:stop()
            sounds.swordShoot:play()
            sword.playSound = false
        end

        if sword.explosion == false then

            sword.animation:update(dt)
            sword.x, sword.y = sword.collider:getPosition()

            if sword.throw == true then
                sword.vectorX, sword.vectorY = (getDirectionVector(sword.direction) * dt * 200):unpack()
                sword.collider:setLinearVelocity(sword.vectorX * sword.speed, sword.vectorY * sword.speed)
            end
        else
            sword.tmpNum = sword.tmpNum + 1.4
            sword.timerFade = sword.timerFade + 1 * dt

            sword.particleUpLeft:update(dt)
            sword.particleDownLeft:update(dt)
            sword.particleUpRight:update(dt)
            sword.particleDownRight:update(dt)
        end

        if Map.type == 'dungeon_1' then
            if (sword.x < 20 or sword.x > 236) or (sword.y < 84 or sword.y > 208) then
                sword.collide = true
            end
        end

        if (sword.x < 0 or sword.x > 256) or (sword.y < 64 or sword.y > 244) then
            sword.collide = true
        elseif sword.collider:enter('Enemy') or sword.collider:enter('IgnoreWallEnemy') then
            sword.collide = true
        end

        if sword.collide == true then
            swordExplosion(i)
        end
    end
end

function swordThrow:draw()
    for i, sword in ipairs(swordThrow) do
        if sword.throw == true then

            if sword.explosion == true then

                sword.particleUpLeft:draw(sprites.swordParticles, sword.x-sword.tmpNum-6, sword.y-sword.tmpNum-4)
                sword.particleDownLeft:draw(sprites.swordParticles, sword.x-sword.tmpNum-6, sword.y+sword.tmpNum-4)
                sword.particleUpRight:draw(sprites.swordParticles, sword.x+sword.tmpNum-6, sword.y-sword.tmpNum-4)
                sword.particleDownRight:draw(sprites.swordParticles, sword.x+sword.tmpNum-6, sword.y+sword.tmpNum-4)
            else
                sword.x, sword.y = sword.collider:getPosition()
                sword.animation:draw(sprites.woodenSword, sword.x-9, sword.y-8)
            end

        end
    end
end

function swordExplosion(index)
    local sword = swordThrow[index]
    sword.explosion = true

    if sword.colliderExists then
        sword.collider:destroy()
        sword.colliderExists = false
    end

    if sword.timerFade >= 0.270 then
        swordThrowDestroy(index)
    end
end

function swordThrowDestroy(index)
    local sword = swordThrow[index]
    table.remove(swordThrow, index)
    swordThrowExists = false
end
