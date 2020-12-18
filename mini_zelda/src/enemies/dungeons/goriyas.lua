goriyas = {}

require 'src/enemies/dungeons/goriyasProjectile'

function spawnGoriya()
    local goriya = {}

    -- Check if the goriya are spawning in the 'dungeon_brick'
    repeat
        goriya.x = multiple16(love.math.random(16,256))
        goriya.y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(goriya.x-8, goriya.y-8)) == 'dungeon_brick'

    goriya.vectorX = 0
    goriya.vectorY = 0

    goriya.speed = 40
    goriya.state = 'idle'
    goriya.damage = 1
    goriya.health = 3
    goriya.invincible = false
    goriya.dead = false

    goriya.directions = {'up', 'down', 'left', 'right'}
    goriya.direction = goriya.directions[math.random(#goriya.directions)]

    goriya.grid = anim8.newGrid(16, 16, sprites.goriya:getWidth(), sprites.goriya:getHeight())
    goriya.animWalkUp = anim8.newAnimation(goriya.grid('1-2', 1), 0.1)
    goriya.animWalkDown = anim8.newAnimation(goriya.grid('1-2', 2), 0.1)
    goriya.animWalkLeft = anim8.newAnimation(goriya.grid('1-2', 3), 0.1):flipH()
    goriya.animWalkRight = anim8.newAnimation(goriya.grid('1-2', 3), 0.1)
    
    goriya.currentAnim = goriya.animWalkUp

    -- center the collider on the sprite
    goriya.collider = world:newRectangleCollider(goriya.x-14, goriya.y-6, 12, 12)
    goriya.collider:setCollisionClass('Enemy')
    goriya.collider:setFixedRotation(true)
    goriya.colliderExists = true

    goriya.shot = false
    goriya.turn = false
    goriya.projectileReturn = false
    goriya.tmpState = 'idle'
    goriya.pushedDirection = 'none'

    goriya.turnTimer = 0
    goriya.pushedTimer = 0
    goriya.invincibleTimer = 0
    
    table.insert(goriyas, goriya)
end

function goriyas:update(dt)

    goriyasProjectile:update(dt)
    -- loop for all goriyas in the table
    for i, goriya in ipairs(goriyas) do

        if goriya.dead then
            goto continue
        end

        if goriya.health <= 0 then
            goriyaDeath(i)
            goto continue
        end

        if goriya.invincible then
            goriya.invincibleTimer = goriya.invincibleTimer + 1 * dt
            if goriya.invincibleTimer >= 0.750 then
                goriya.invincible = false
            end
        end

        goriya.currentAnim:update(dt)
        goriya.x, goriya.y = goriya.collider:getPosition()

        goriya.vectorX = 0
        goriya.vectorY = 0

        checkGoriyaDamage(i)
        checkIfGoriyaHitPlayer(i)

        if goriya.collider:enter('Wall') then
            turnGoriya(i)
        end

        if goriya.state == 'idle' then

            -- set a timer for goriya actions
            goriya.turnTimer = goriya.turnTimer + 1 * dt
            if goriya.turnTimer >= 1 then
                if math.random(3) == 1 then
                    goriya.turn = true
                    goriya.turnTimer = 0

                elseif math.random(3) == 1 then
                    goriya.state = 'shooting'
                    goriya.turnTimer = 0
                    goriya.shot = false
                    goriya.projectileReturn = false
                    goto continue
                end

                if checkIfSeePlayer(goriya.x, goriya.y, goriya.direction) == true and 
                    distanceFrom(goriya.x, goriya.y, Player.x, Player.y) <= 96 then

                    goriya.state = 'shooting'
                    goriya.turnTimer = 0
                    goriya.shot = false
                    goriya.projectileReturn = false
                    goto continue
                end
            end

            if goriya.turn == true then
                if distanceFrom(goriya.x, goriya.y, multiple16(goriya.x)+8, multiple16(goriya.y+4)) < 1 then
                    
                    turnGoriya(i)
                    goriya.turnTimer = 0
                    goriya.turn = false
                end
            end

            setGoriyaDirection(i)
            goriya.collider:setLinearVelocity(goriya.vectorX * goriya.speed, goriya.vectorY * goriya.speed)

        elseif goriya.state == 'shooting' then
            setGoriyaDirection(i)
            goriya.collider:setLinearVelocity(0, 0)
            if goriya.shot == false then
                goriyasProjectileSpawn(goriya.x, goriya.y, goriya.direction, i)
                goriya.shot = true
            end
            if goriya.projectileReturn then
                goriya.state = 'idle'
                local directions = checkArea(goriya.x, goriya.y)
                if not contains(goriya.direction, directions) then
                    goriya.direction = directions[math.random(#directions)]
                end
            end

        elseif goriya.state == 'pushed' then

            goriya.x, goriya.y = goriya.collider:getPosition()
            local x, y = (getDirectionVector(goriya.pushedDirection) * dt * 600):unpack()
            goriya.collider:setLinearVelocity(x * goriya.speed, y * goriya.speed)

            goriya.pushedTimer = goriya.pushedTimer + 1 * dt
            if goriya.pushedTimer >= 0.133 then
                goriya.state = goriya.tmpState
            end
        end
        ::continue::
    end
end

function goriyas:draw()
    goriyasProjectile:draw()
    for i, goriya in ipairs(goriyas) do

        if goriya.dead then
            goto continue
        end

        if goriya.invincible then
            -- makes the sprite blink white
            if math.floor(math.cos(love.timer.getTime() * 18 % 2 * math.pi)) == 0 then
                love.graphics.setShader(white_flash)
            end
        else
            love.graphics.setShader()
        end

        goriya.currentAnim:draw(sprites.goriya, goriya.x-8, goriya.y-8)
        love.graphics.setColor(1,1,1,1)
        ::continue::
    end
end

function setGoriyaDirection(index)
    local goriya = goriyas[index]

    if goriya.direction == 'up' then
        goriya.vectorY = -1
        goriya.currentAnim = goriya.animWalkUp

    elseif goriya.direction == 'down' then
        goriya.vectorY = 1
        goriya.currentAnim = goriya.animWalkDown

    elseif goriya.direction == 'left' then
        goriya.vectorX = -1
        goriya.currentAnim = goriya.animWalkLeft

    elseif goriya.direction == 'right' then
        goriya.vectorX = 1
        goriya.currentAnim = goriya.animWalkRight
    end
end

function checkGoriyaDamage(index)
    local goriya = goriyas[index]
    if goriya.invincible == true then return end

    if goriya.collider:enter('Weapon') then
        local sword
        for i, swordT in ipairs(swordThrow) do
            sword = swordT
        end

        goriya.pushedTimer = 0
        goriya.invincibleTimer = 0
        goriya.invincible = true
        goriya.tmpState = goriya.state
        goriya.state = 'pushed'
        if sword == nil then
            goriya.pushedDirection = Sword.direction
        else
            goriya.pushedDirection = sword.direction
        end
        goriya.health = goriya.health - Sword.damage

        if goriya.health > 0 then
            sounds.enemyHit:stop()
            sounds.enemyHit:play()
        end

    elseif goriya.collider:enter('Arrow') then
        goriya.pushedTimer = 0
        goriya.invincibleTimer = 0
        goriya.invincible = true
        goriya.tmpState = goriya.state
        goriya.state = 'pushed'
        goriya.pushedDirection = arrows[1].direction
        goriya.health = goriya.health - arrows[1].damage

        if goriya.health > 0 then
            sounds.enemyHit:stop()
            sounds.enemyHit:play()
        end
    end
end

function checkIfGoriyaHitPlayer(index)
    local goriya = goriyas[index]
    if goriya.collider:enter('Player') then
        playerDamage(goriya.damage)
    end
end

function turnGoriya(index)
    local goriya = goriyas[index]
    -- create 4 queries around the collider for get the availables directions  
    local directions = checkArea(goriya.x, goriya.y)
    goriya.direction = directions[math.random(#directions)]
    -- center the collider position in the block
    goriya.collider:setPosition(multiple16(goriya.x+2)+8, multiple16(goriya.y+2))
end

function goriyaDeath(index)
    local goriya = goriyas[index]

    deathSpawn(goriya.x-7.5, goriya.y-7.5, enemyDrops())

    for i, projectile in ipairs(goriyasProjectile) do
        -- check if goriya has a projectile and delete it
        if projectile.id == index then
            goriyasProjectileRemove(i)
        end
    end

    if goriya.colliderExists then
        goriya.collider:destroy()
        goriya.colliderExists = false
    end

    -- subtracts a goriya from the goriyas list in the current room
    enemiesDungeon1_rooms[currentDungeonRoom][4] = enemiesDungeon1_rooms[currentDungeonRoom][4] - 1

    goriya.dead = true
end

function deleteGoriyas()
    deleteAllGoriyasProjectile()
    for i, goriya in ipairs(goriyas) do
        if goriya.colliderExists then
            goriya.collider:destroy()
            goriya.colliderExists = false
        end
        table.remove(goriyas, i)
    end
end
