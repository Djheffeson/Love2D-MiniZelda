deaths = {}

local grid = anim8.newGrid(16, 16, sprites.deathSheet:getWidth(), sprites.deathSheet:getHeight())

function deathSpawn(x, y, itemDrop)
    local death = {}
    death.x = x
    death.y = y
    death.itemDrop = itemDrop

    death.Animation = anim8.newAnimation(grid(1,1, 2,1, 1,1), 0.1)
    death.timer = 0
    table.insert(deaths, death)
    sounds.enemyDie:stop()
    sounds.enemyDie:play()
    enemyDeathCount = enemyDeathCount + 1
end

function deaths:update(dt)
    for i = #deaths, 1, -1 do
        deaths[i].Animation:update(dt)
        deaths[i].timer = deaths[i].timer + 1 * dt
        if deaths[i].timer >= 0.3 then
            if deaths[i].itemDrop ~= 0 then
                spawnItem(deaths[i].itemDrop, deaths[i].x, deaths[i].y)
            end
            table.remove(deaths, i)
        end
    end
end

function deaths:draw()
    for i, death in ipairs(deaths) do
        death.Animation:draw(sprites.deathSheet, death.x, death.y)
    end
end
