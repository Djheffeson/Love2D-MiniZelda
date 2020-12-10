zoraProjectile = {}

function zoraProjectileCharge(x, y, targetX, targetY)
    local projectile = {}

    projectile.x = x
    projectile.y = y

    projectile.dx, projectile.dy = checkDistance(targetX, targetY, x, y)

    projectile.dx = projectile.dx * 14
    projectile.dy = projectile.dy * 14

    projectile.grid = anim8.newGrid(8, 10, 
        sprites.ball_projectile:getWidth(), sprites.ball_projectile:getHeight())
    projectile.sprite = anim8.newAnimation(projectile.grid('1-6', 1), 0.017)

    projectile.shot = false

    table.insert(zoraProjectile, projectile)
end

function zoraProjectileShoot()
    for i, projectile in ipairs(zoraProjectile) do
        projectile.shot = true
    end
end

function zoraProjectileCollideWithPlayer()
    for i, projectile in ipairs(zoraProjectile) do
        if distanceFrom(Player.x+8, Player.y, projectile.x+4, projectile.y+4) <= 8 then
            playerDamage(0.5)
            zoraProjectileRemove()
        end
    end
end

function zoraProjectile:update(dt)
    for i, projectile in ipairs(zoraProjectile) do
        zoraProjectileCollideWithPlayer()
        if projectile.shot == true then
            projectile.x = projectile.x + projectile.dx * dt
            projectile.y = projectile.y + projectile.dy * dt
        end
        projectile.sprite:update(dt)
    end
end

function zoraProjectile:draw()
    for i, projectile in ipairs(zoraProjectile) do
        projectile.sprite:draw(sprites.ball_projectile, projectile.x-12, projectile.y-4)
    end
end

function zoraProjectileRemove()
    for i, projectile in ipairs(zoraProjectile) do
        table.remove(zoraProjectile, i)
    end
end
