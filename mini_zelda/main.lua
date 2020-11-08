function love.load()
    require 'src/gameStart'
    gameStart()

    map:init()
    sword:init()
    player:init()
    GUI:init()
    enemies = {}
    for i=1, 5, 1 do
        table.insert(enemies, Enemy())
    end
    
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    map:update(dt)
    sword:update(dt)
    player:update(dt)
    GUI:update(dt)
    world:update(dt)
    for i, enemies in pairs(enemies) do
        enemies:update(dt)
    end
    
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    
    map:draw()
    for i, enemies in pairs(enemies) do
        enemies:draw()
    end
    sword:draw()
    player:draw()
    GUI:draw()
    --world:draw() -- debug collisions

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'v' then
        Player.hearts = Player.hearts - 0.5
    end
    if key == 'b' then
        Player.hearts = Player.hearts + 0.5
    end
    love.keyboard.keysPressed[key] = true
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

