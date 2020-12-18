goriyasProjectile = {}

function goriyasProjectileSpawn(x, y, direction, id)
    local projectile = {}

    projectile.id = id
    projectile.x = x
    projectile.y = y
    projectile.direction = direction
    projectile.initialSpeed = 120
    projectile.speed = projectile.initialSpeed

    projectile.hit = false
    projectile.owner = goriyas[projectile.id]

    projectile.dx = 0
    projectile.dy = 0

    projectile.sprite = sprites.boomerang
    projectile.angle = 0
    projectile.returning = false
    projectile.waitTimer = 0

    table.insert(goriyasProjectile, projectile)
end

function goriyasProjectile:update(dt)
    for i, projectile in ipairs(goriyasProjectile) do

        checkIfGoriyaProjectileHitPlayer(i)
        
        projectile.speed = projectile.initialSpeed
        projectile.owner = goriyas[projectile.id]

        -- check if the projectile hit the wall
        if (projectile.x <= 26 or projectile.x >= 232) or (projectile.y <= 80 or projectile.y >= 206) then
            if projectile.returning == false then
                projectile.returning = true
                projectile.hit = true
                projectile.waitTimer = -0.05
            end
        end
        
        -- create a delay for the projectile stay on the wall for a few milliseconds
        projectile.waitTimer = projectile.waitTimer + 1 * dt
        if projectile.waitTimer < 0 then
            goto continue
        end

        -- check if the projectile reach the maximum range
        if distanceFrom(projectile.x, projectile.y, projectile.owner.x, projectile.owner.y) >= 112 then
            projectile.returning = true
        end

        -- if projectile is returning
        if projectile.returning then
            projectile.hit = false
            if distanceFrom(projectile.x, projectile.y, projectile.owner.x, projectile.owner.y) < 12 then
                projectile.owner.projectileReturn = true
                goriyasProjectileRemove(i)
                goto continue
            end
            projectileBackToGoriya(i)
        end
        
        -- set the projectile direction
        if projectile.returning == false then
            projectile.dx = 0
            projectile.dy = 0
            if projectile.direction == 'up' then
                projectile.dy = -projectile.speed
            end

            if projectile.direction == 'down' then 
                projectile.dy = projectile.speed
            end

            if projectile.direction == 'left' then
                projectile.dx = -projectile.speed
            end

            if projectile.direction == 'right' then
                projectile.dx = projectile.speed
            end
        end

        -- move the projectile
        projectile.x = projectile.x + projectile.dx * dt
        projectile.y = projectile.y + projectile.dy * dt

        ::continue::
        
        -- change the angle of the rotation of the projectile
        projectile.angle = projectile.angle + 1
        if projectile.angle >= 359 then
            projectile.angle = 0
        end
    end
end

function goriyasProjectile:draw()
    for i, projectile in ipairs(goriyasProjectile) do
        if projectile.hit then
            love.graphics.draw(sprites.splash, projectile.x, projectile.y, 0, 1, 1, 2.5, 4)
        else
            love.graphics.draw(projectile.sprite, projectile.x, projectile.y, math.deg(projectile.angle), 1, 1, 2.5, 4)
        end
    end
end

function projectileBackToGoriya(index)
    local projectile = goriyasProjectile[index]
    
    -- make the projectile follow the goriya
    if projectile.x < projectile.owner.x then
        projectile.dx = projectile.speed
    end

    if projectile.x > projectile.owner.x then
        projectile.dx = -projectile.speed
    end

    if projectile.y < projectile.owner.y then
        projectile.dy = projectile.speed
    end

    if projectile.y > projectile.owner.y then
        projectile.dy = -projectile.speed
    end
end

function checkIfGoriyaProjectileHitPlayer(index)
    local projectile = goriyasProjectile[index]
    if distanceFrom(projectile.x, projectile.y, Player.x, Player.y) < 14 then
        if projectile.speed > 0 then
            projectile.returning = true
        end
        playerDamage(projectile.owner.damage)
    end
end

function goriyasProjectileRemove(index)
    local projectile = goriyasProjectile[index]
    table.remove(goriyasProjectile, index)
end

function deleteAllGoriyasProjectile()
    for i=#goriyasProjectile, 0, -1 do
        table.remove(goriyasProjectile, i)
    end
end
