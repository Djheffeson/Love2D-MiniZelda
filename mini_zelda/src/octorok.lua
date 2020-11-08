local octorok = {}

function newOctorok(x, y)
    octorok.width = 16
    octorok.height = 16
    octorok.speed = love.math.random(40, 80)

    octorok.x = x
    octorok.y = y

    octorok.vectorX = 0
    octorok.vectorY = 0

    octorok.health = 1
    octorok.damage = 0.5
    octorok.projectile_hit = true

    local directions = {'up', 'down', 'left', 'right'}
    octorok.direction = directions[math.random(#directions)]
    octorok.state = 'walking'

    octorok.collider = world:newCircleCollider(octorok.x, octorok.y, 7)
    octorok.collider:setCollisionClass('Enemy')
    octorok.collider:setObject(octorok)

    octorok.collider_front = world:newCircleCollider(octorok.x, octorok.y, 4)
    octorok.collider_front:setCollisionClass('Enemy')

    octorok.collider_projectile = world:newCircleCollider(octorok.x, octorok.y, 6)
    octorok.collider_projectile:setCollisionClass('Enemy')

    octorok.grid = anim8.newGrid(16, 16, sprites.octorokSheet:getWidth(), sprites.octorokSheet:getHeight())
    octorok.animationDown = anim8.newAnimation(octorok.grid('1-2', 1), 0.1)
    octorok.animationUp = anim8.newAnimation(octorok.grid('1-2', 1), 0.1):flipV()
    octorok.animationLeft = anim8.newAnimation(octorok.grid('1-2', 2), 0.1):flipH()
    octorok.animationRight = anim8.newAnimation(octorok.grid('1-2', 2), 0.1)

    octorok.currentAnimation = octorok.animationDown

    octorok.timer_actions = 0
    octorok.timer_attack = 0
    octorok.shot = true

    table.insert(enemies, octorok)
    
end

function octorok:update(dt)

    octorok.timer_attack = octorok.timer_attack + 1 * dt
    if octorok.state == 'attacking' then 
        
        octorok.collider:setLinearVelocity(0, 0)
        if octorok.timer_attack >= 0.850 then
            octorok.state = 'walking'
            directAvailable = checkDirection(octorok.x, octorok.y)
            octorok.direction = directAvailable[math.random(#directAvailable)]
            octorok.vectorX = 0
            octorok.vectorY = 0
        end
        
        if octorok.timer_attack >= 0.600 and octorok.shot == false then
            octorok.collider_projectile:setLinearVelocity(octorok.vectorX * 200, octorok.vectorY * 200)
            octorok.projectileHit = false
            octorok.shot = true
        end
    end

    if octorok.collider_projectile:enter('Wall') or octorok.collider_projectile:enter('Player')then
        octorok.projectileHit = true
        octorok.collider_projectile:setLinearVelocity(0, 0)
    end

    octorok.currentAnimation:update(dt)
    octorok.projectileX, octorok.projectileY = octorok.collider_projectile:getPosition()

    if octorok.state ~= 'attacking' then
        octorok.x, octorok.y = octorok.collider:getPosition()

        if octorok.collider_front:enter('Wall') then octorok.state = 'colliding' end
        if octorok.collider_front:exit('Wall') then octorok.state = 'walking' end

        if octorok.state == 'colliding' then
            directAvailable = checkDirection(octorok.x, octorok.y)
            octorok.direction = directAvailable[math.random(#directAvailable)]
            octorok.vectorX = 0
            octorok.vectorY = 0
            octorok.state = 'walking'
        end

        octorok.timer_actions = octorok.timer_actions + 1 * dt
        if octorok.timer_actions > 1 then
            octorok.timer_actions = 0
            if math.random(3) == 1 then
                directAvailable = checkDirection(octorok.x, octorok.y)
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

        octorok.collider:setLinearVelocity(octorok.vectorX * octorok.speed, octorok.vectorY * octorok.speed)
        octorok.direction = getDirection(octorok.vectorX, octorok.vectorY)
        if octorok.projectileHit then
            octorok.collider_projectile:setPosition(octorok.x, octorok.y)
        end
    end
end

function octorok:draw()
    if octorok.projectileHit == false then
        love.graphics.draw(sprites.octorok_projectile, octorok.projectileX-4, octorok.projectileY-4)
    end
    octorok.currentAnimation:draw(sprites.octorokSheet, octorok.x-8, octorok.y-8)
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

function checkDirection(px, py)

    cLeft = world:queryCircleArea(px-9, py, 4, {'Wall'})
    cRight = world:queryCircleArea(px+9, py, 4, {'Wall'})
    cBack = world:queryCircleArea(px, py+9, 4, {'Wall'})
    cFront = world:queryCircleArea(px, py-9, 4, {'Wall'})

    directAvailable = {}
    if #cLeft <= 0 then
        table.insert(directAvailable, 'left')
    end
    if #cRight <= 0 then
        table.insert(directAvailable, 'right')
    end
    if #cBack <= 0 then
        table.insert(directAvailable, 'down')
    end
    if #cFront <= 0 then
        table.insert(directAvailable, 'up')
    end

    return directAvailable
end