octoroks = {}

function spawnOctorok(type)

    local octorok = {}
    octorok.type = type
    
    repeat
        octorok.x = multiple16(love.math.random(16,256))
        octorok.y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(octorok.x-8, octorok.y-8)) == 'sand'
    
    octorok.walk = love.math.random(40, 50)
    octorok.vectorX = 0
    octorok.vectorY = 0

    octorok.invincible = false

    if octorok.type == 'red' then
        octorok.sprite = sprites.redOctorokSheet
        octorok.health = 1
    elseif octorok.type == 'blue' then
        octorok.sprite = sprites.blueOctorokSheet
        octorok.health = 2
    end
    
    octorok.damage = 0.5

    octorok.projectileHit = true

    octorok.collisionDestroyed = false

    -- Choose a direction for the enemy start
    local directions = {'up', 'down', 'left', 'right'}
    octorok.direction = directions[math.random(#directions)]
    octorok.state = 'walking'
    
    -- Create a collision for the enemy
    octorok.collider = world:newCircleCollider(octorok.x, octorok.y, 7)
    octorok.collider:setCollisionClass('Enemy')
    octorok.collider:setObject(octorok)

    -- Create a collider in front of the enemy for check if they collide with anything 
    octorok.collider_front = world:newCircleCollider(octorok.x, octorok.y, 4)
    octorok.collider_front:setCollisionClass('EnemyCollider')

    -- Create a collider for the projectile
    octorok.collider_projectile = world:newCircleCollider(octorok.x, octorok.y, 5)
    octorok.collider_projectile:setCollisionClass('EnemyWeapon')
    
    octorok.grid = anim8.newGrid(16, 16,  octorok.sprite:getWidth(), sprites.redOctorokSheet:getHeight())
    octorok.animationDown = anim8.newAnimation(octorok.grid('1-2', 1), 0.1)
    octorok.animationUp = anim8.newAnimation(octorok.grid('1-2', 1), 0.1):flipV()
    octorok.animationLeft = anim8.newAnimation(octorok.grid('1-2', 2), 0.1):flipH()
    octorok.animationRight = anim8.newAnimation(octorok.grid('1-2', 2), 0.1)

    octorok.currentAnimation = octorok.animationDown
    
    octorok.pushedDirection = 'none'

    octorok.timer_actions = 0
    octorok.timer_attack = 0
    octorok.timer_invincible = 0
    octorok.timer_push = 0
    octorok.shot = false

    table.insert(octoroks, octorok)

end

function octoroks:update(dt)

    for i, octorok in ipairs(octoroks) do

        if not (octorok.health <= 0) then

            if octorok.collider:enter('Weapon') and octorok.invincible == false then

                local sword
                for i, swordT in ipairs(swordThrow) do
                    sword = swordT
                end

                octorok.health = octorok.health - Sword.damage
                octorok.invincible = true
                octorok.timer_invincible = 0
                octorok.timer_push = 0
                octorok.state = 'pushed'
                if sword == nil then
                    octorok.pushedDirection = Sword.direction
                else
                    octorok.pushedDirection = sword.direction
                end
                if octorok.health >= 1 then
                    sounds.enemyHit:stop()
                    sounds.enemyHit:play()
                end

            elseif octorok.collider:enter('Arrow') and octorok.invincible == false then
                octorok.health = octorok.health - arrows[1].damage
                octorok.invincible = true
                octorok.timer_invincible = 0
                octorok.timer_push = 0
                octorok.state = 'pushed'
                octorok.pushedDirection = arrows[1].direction

                if octorok.health >= 1 then
                    sounds.enemyHit:stop()
                    sounds.enemyHit:play()
                end
            end
            
            if octorok.invincible == true then
                octorok.timer_invincible = octorok.timer_invincible + 1 * dt
                if octorok.timer_invincible >= 0.750 then
                    octorok.invincible = false
                end
            end
            
            if octorok.collider_front:enter('Wall') then octorok.state = 'colliding' end
            if octorok.collider_front:exit('Wall') then octorok.state = 'walking' end

            if octorok.collider_projectile:enter('Wall') or octorok.collider_projectile:enter('Player') then
                octorok.projectileHit = true
                octorok.collider_projectile:setLinearVelocity(0, 0)
            end

            octorok.currentAnimation:update(dt)
            octorok.cX, octorok.cY = octorok.collider_projectile:getPosition()

            -- Check if enemy or projectile collide with player
            if octorok.collider:enter('Player') or octorok.collider_projectile:enter('Player') then
                playerDamage(octorok.damage)
            end

            if octorok.state == 'pushed' then
                octorok.timer_push = octorok.timer_push + 1 * dt
                octorok.x, octorok.y = octorok.collider:getPosition()

                local x, y = (getDirectionVector(octorok.pushedDirection)  * dt * 600):unpack()
                octorok.collider:setLinearVelocity(x * octorok.walk, y * octorok.walk)

                if octorok.timer_push >= 0.133 then
                    octorok.state = 'walking'
                end
            end

            octorok.timer_attack = octorok.timer_attack + 1 * dt
            if octorok.state == 'attacking' then 
                
                octorok.collider:setLinearVelocity(0, 0)
                octorok.collider_front:setLinearVelocity(0, 0)

                if octorok.timer_attack >= 0.850 then
                    octorok.state = 'walking'
                    directAvailable = checkArea(octorok.x, octorok.y)
                    if not contains(octorok.direction, directAvailable) then
                        octorok.direction = directAvailable[math.random(#directAvailable)]
                        octorok.vectorX = 0
                        octorok.vectorY = 0
                    end
                end
                
                if octorok.timer_attack >= 0.600 and octorok.shot == false then
                    octorok.collider_projectile:setLinearVelocity(octorok.vectorX * 200, octorok.vectorY * 200)
                    octorok.projectileHit = false
                    octorok.shot = true
                end
            end

            if octorok.state ~= 'attacking' and octorok.state ~= 'pushed' then
                octorok.x, octorok.y = octorok.collider:getPosition()

                if octorok.state == 'colliding' then
                    directAvailable = checkArea(octorok.x, octorok.y)
                    octorok.direction = directAvailable[math.random(#directAvailable)]
                    octorok.vectorX = 0
                    octorok.vectorY = 0
                    octorok.state = 'walking'
                end

                octorok.timer_actions = octorok.timer_actions + 1 * dt
                if octorok.timer_actions > 1 then
                    octorok.timer_actions = 0

                    if octorok.state ~= 'attacking' then
                        if checkIfSeePlayer(octorok.x, octorok.y, octorok.direction) then
                            octorok.state = 'attacking'
                            octorok.timer_attack = 0
                            octorok.shot = false
                        end
                    end
                    
                    if math.random(3) == 1 then
                        directAvailable = checkArea(octorok.x, octorok.y)
                        octorok.direction = directAvailable[math.random(#directAvailable)]
                        octorok.vectorX = 0
                        octorok.vectorY = 0
                        octorok.state = 'walking'

                    elseif math.random(3) == 1 then
                        octorok.state = 'attacking'
                        octorok.timer_attack = 0
                        octorok.shot = false
                    end
                end
                
                if octorok.direction == 'up' then
                    octorok.vectorY = -1
                    octorok.currentAnimation = octorok.animationUp
                    octorok.collider_front:setPosition(octorok.x, octorok.y-6)

                elseif octorok.direction == 'down' then
                    octorok.vectorY = 1
                    octorok.currentAnimation = octorok.animationDown
                    octorok.collider_front:setPosition(octorok.x, octorok.y+6)

                elseif octorok.direction == 'left' then
                    octorok.vectorX = -1
                    octorok.currentAnimation = octorok.animationLeft
                    octorok.collider_front:setPosition(octorok.x-6, octorok.y)

                elseif octorok.direction == 'right' then
                    octorok.vectorX = 1
                    octorok.currentAnimation = octorok.animationRight
                    octorok.collider_front:setPosition(octorok.x+6, octorok.y)
                end

                octorok.collider:setLinearVelocity(octorok.vectorX * octorok.walk, octorok.vectorY * octorok.walk)
                octorok.collider_front:setLinearVelocity(octorok.vectorX * octorok.walk, octorok.vectorY * octorok.walk)

                octorok.direction = getDirection(octorok.vectorX, octorok.vectorY)
                if octorok.projectileHit then
                    octorok.collider_projectile:setPosition(octorok.x, octorok.y)
                end
            end
        else
            if octorok.collisionDestroyed == false then
                octorok.collider:destroy()
                octorok.collider_front:destroy()
                octorok.collider_projectile:destroy()
                octorok.collisionDestroyed = true
            end
            if octorok.type == 'red' then
                enemies_room[currentOverworldRoom][1] = enemies_room[currentOverworldRoom][1] - 1 
            elseif octorok.type == 'blue' then
                enemies_room[currentOverworldRoom][2] = enemies_room[currentOverworldRoom][2] - 1 
            end
            local item = enemyDrops()
            deathSpawn(octorok.x-8, octorok.y-8, item)
            table.remove(octoroks, i)
        end
    end
end

function octoroks:draw()
    for i, octorok in ipairs(octoroks) do
        love.graphics.setColor(1, 1, 1, 1)
        if not (octorok.health <= 0) then
            if octorok.projectileHit == false then
                love.graphics.draw(sprites.octorok_projectile, octorok.cX-4, octorok.cY-4)
            end

            if octorok.invincible then
                if math.floor(math.cos(love.timer.getTime() * 18 % 2 * math.pi)) == 0 then
                    love.graphics.setShader(white_flash)
                end
            end
            octorok.currentAnimation:draw(octorok.sprite, octorok.x-8, octorok.y-8)
            love.graphics.setShader()
        end
    end
end

function getDirection(vectX, vectY)
    if vectY == -1 then
        direction = 'up'
    elseif vectY == 1 then
        direction = 'down'
    elseif vectX == -1 then
        direction = 'left'
    elseif vectX == 1 then
        direction = 'right'
    end
    return direction
end

function deleteOctoroks()
    for i, octorok in ipairs(octoroks) do
        octorok.collider:destroy()
        octorok.collider_front:destroy()
        octorok.collider_projectile:destroy()
        octorok.collisionDestroyed = true
        table.remove(octoroks, i)
    end
end
