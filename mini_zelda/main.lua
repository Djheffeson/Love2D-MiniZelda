function love.load()
    
    require 'src/startup/gameStart'
    gameStart()

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    map:update(dt)
    map1:update(dt)
    items:update(dt)
    sword:update(dt)
    player:update(dt)
    GUI:update(dt)
    world:update(dt)
    deaths:update(dt)
    enemies:update(dt)
    doors:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    love.graphics.clear(23/255, 75/255, 1, 1)

    push:start()

    map1:draw()
    items:draw()
    deaths:draw()
    enemies:draw()
    sword:draw()
    player:draw()
    doors:draw()
    GUI:draw()
    --world:draw() -- debug collisions

    push:finish()
end

function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true

    -- keys for debug:
    if key == 'v' then
        playerDamage(0.5)
    end
    if key == 'b' then
        playerHeal(0.5)
    end
    if key == '1' then
        spawnItem(1, 100, 100)
    end
    if key == '2' then
        spawnItem(2, 132, 120)
    end

end
 
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end
