aquamentusProjectile = {}


function spawnAquaProjectiles(x, y)
    for i=-1, 1, 1 do
        local projectile = {}

        projectile.x = x
        projectile.y = y

        projectile.damage = 0.5

        projectile.speed = 80
        projectile.pos = i
        projectile.angle = math.atan2((Player.y-8)-projectile.y, Player.x-projectile.x)
        
        projectile.sprite = sprites.ball_projectile
        projectile.grid = anim8.newGrid(8, 10, projectile.sprite:getWidth(), projectile.sprite:getHeight())
        projectile.animation = anim8.newAnimation(projectile.grid('1-6', 1), 0.017)

        projectile.timer = 0

        table.insert(aquamentusProjectile, projectile)
    end
end

function aquamentusProjectile:update(dt)
    for i, projectile in ipairs(aquamentusProjectile) do
        projectile.animation:update(dt)

        projectile.timer = projectile.timer + 1 * dt
        if projectile.timer <= 0.22 then
            projectile.y = projectile.y + projectile.pos
        else
            checkIfCollideWithPlayer(i)

            projectile.y = projectile.y + projectile.pos / 3
            projectile.x = projectile.x + math.cos(projectile.angle) * dt * projectile.speed
            projectile.y = projectile.y + math.sin(projectile.angle) * dt * projectile.speed

            if (projectile.x <= 26 or projectile.x >= 232) or (projectile.y <= 80 or projectile.y >= 206) then
                removeAquaProjectile(i)
            end
        end
    end
end

function aquamentusProjectile:draw()
    for i, projectile in ipairs(aquamentusProjectile) do
        projectile.animation:draw(projectile.sprite, projectile.x, projectile.y)
    end
end

function checkIfCollideWithPlayer(index)
    local projectile = aquamentusProjectile[index]
    if distanceFrom(Player.x+8, Player.y, projectile.x+4, projectile.y+4) <= 8 then
        playerDamage(0.5)
        removeAquaProjectile(index)
    end
end

function removeAquaProjectile(index)
    table.remove(aquamentusProjectile, index)
end

function deleteAquaProjectiles()
    for i=#aquamentusProjectile, 0, -1 do
        table.remove(aquamentusProjectile, i)
    end
end
