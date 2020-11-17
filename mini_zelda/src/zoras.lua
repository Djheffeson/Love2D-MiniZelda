zoras = {}

require 'src/zoraProjectile'

function spawnZora()
    local zora = {}

    repeat
        zora.x = multiple16(love.math.random(16,256))
        zora.y = multiple16(love.math.random(72,224))
    until checkLayer('Water_layer', map:convertPixelToTile(zora.x + 12, zora.y + 12)) == 'water'

    zora.health = 1
    zora.state = 'sink'
    zora.shooting = false
    zora.charging = false

    zora.grid = anim8.newGrid(16, 16, sprites.zoraSheet:getWidth(), sprites.zoraSheet:getHeight())
    zora.animationEmerging = anim8.newAnimation(zora.grid('1-2', 1), 0.18)
    zora.animationFront = anim8.newAnimation(zora.grid(1, 2), 1)
    zora.animationBack = anim8.newAnimation(zora.grid(2, 2), 1)
    zora.currentAnimation = zora.animationEmerging

    zora.collider = world:newRectangleCollider(zora.x-16, zora.y-8, 16, 16)
    zora.collider:setFixedRotation(true)
    zora.collider:setCollisionClass('WaterEnemy')
    zora.colliderExists = true

    zora.emergeTimer = 0

    table.insert(zoras, zora)
end

function zoras:update(dt)
    for i, zora in ipairs(zoras) do
        if zora.health > 0 then

            zoraCheckDamage(i)
            zora.emergeTimer = zora.emergeTimer + 1 * dt
            if zora.emergeTimer >= 0.533 and zora.emergeTimer < 0.850 then
                if zora.state == 'sink' then
                    zora.state = 'emerge'
                    zora.shooting = false
                    zora.charging = false
                    zoraEmerge(i)
                end
            end

            if zora.emergeTimer >= 0.850 then
                if zora.charging == false then
                    zoraProjectileCharge(zora.x, zora.y, Player.x, Player.y)
                    zora.charging = true
                end
                if zora.emergeTimer >= 1.150 and zora.shooting == false then
                    zoraProjectileShoot()
                    zora.shooting = true
                end
            end

            if zora.emergeTimer >= 1.617 then
                if zora.state == 'emerge' then
                    zora.currentAnimation = zora.animationEmerging
                    zora.state = 'sink'
                end
            end

            if zora.emergeTimer >= 3.217 then
                zora.emergeTimer = 0
                zoraNewPosition(i)
                zoraProjectileRemove()
            end

            if zora.state == 'emerge' and zora.colliderExists == false then
                zora.collider = world:newRectangleCollider(zora.x-16, zora.y-8, 16, 16)
                zora.collider:setFixedRotation(true)
                zora.collider:setCollisionClass('WaterEnemy')
                zora.colliderExists = true

            elseif zora.state == 'sink' and zora.colliderExists == true then
                zora.collider:destroy()
                zora.colliderExists = false
            end

            zoraProjectile:update(dt)
            zora.currentAnimation:update(dt)

        else
            deathSpawn(zora.x-16, zora.y-8, 0)
            deleteZoras()
        end
    end
end

function zoras:draw()
    for i, zora in ipairs(zoras) do
        zora.currentAnimation:draw(sprites.zoraSheet, zora.x-16, zora.y-8)
        zoraProjectile:draw()
    end
end

function zoraEmerge(index)
    zoras[index].currentAnimation = zoras[index].animationFront
end

function zoraNewPosition(index)

    local x = 0
    local y = 0

    repeat
        x = multiple16(love.math.random(16,256))
        y = multiple16(love.math.random(72,224))
    until checkLayer('Water_layer', 
        map:convertPixelToTile(x, y)) == 'water'

    zoras[index].x = x 
    zoras[index].y = y
end

function zoraCheckDamage(index)
    if zoras[index].collider:enter('Weapon') then
        zoras[index].health = zoras[index].health - Sword.damage
    end
end

function deleteZoras()
    for i, zora in ipairs(zoras) do
        table.remove(zoras, i)
        zoraProjectileRemove()
        if zora.colliderExists == true then
            zora.collider:destroy()
            zora.colliderExists = false
        end
    end
end