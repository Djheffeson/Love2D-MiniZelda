zoras = {}

function spawnZora()
    local zora = {}

    repeat
        zora.x = love.math.random(0,256)
        zora.y = love.math.random(56,224)
    until checkLayer('Water_layer', map:convertPixelToTile(zora.x + 12, zora.y + 12)) == 'water'

    zora.state = 'sink'

    zora.grid = anim8.newGrid(16, 16, sprites.zoraSheet:getWidth(), sprites.zoraSheet:getHeight())
    zora.animationEmerging = anim8.newAnimation(zora.grid('1-2', 1), 0.18)
    zora.animationFront = anim8.newAnimation(zora.grid(1, 2), 1)
    zora.animationBack = anim8.newAnimation(zora.grid(2, 2), 1)

    zora.currentAnimation = zora.animationEmerging
    
    zora.projectileGrid = anim8.newGrid(8, 10, sprites.zoraProjectileSheet:getWidth(), 
        sprites.zoraProjectileSheet:getHeight())
    zora.projectileSprite = anim8.newAnimation(zora.projectileGrid('1-6', 1), 0.1)

    zora.emergeTimer = 0

    table.insert(zoras, zora)
end

function zoras:update(dt)
    for i, zora in ipairs(zoras) do
        zora.emergeTimer = zora.emergeTimer + 1 * dt
        if zora.emergeTimer >= 0.533 then
            if zora.state == 'sink' then
                zora.state = 'emerge'
                zoraEmerge(i)
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
        end
        zora.currentAnimation:update(dt)
    end
end

function zoras:draw()
    for i, zora in ipairs(zoras) do
        zora.currentAnimation:draw(sprites.zoraSheet, zora.x-8, zora.y-8)
    end
end

function zoraEmerge(index)
    zoras[index].currentAnimation = zoras[index].animationFront
end

function zoraShoot(index)
    -- TODO
end

function zoraNewPosition(index)

    local x = 0
    local y = 0

    repeat
        x = love.math.random(0,256)
        y = love.math.random(56,224)
    until checkLayer('Water_layer', 
        map:convertPixelToTile(x + 12, y + 12)) == 'water'

    zoras[index].x = x
    zoras[index].y = y
end

function deleteZoras()
    for i, zora in ipairs(zoras) do
        table.remove(zoras, i)
    end
end