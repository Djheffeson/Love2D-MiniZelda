function love.load()
    require 'src/gameStart'
    gameStart()

    map:init()
    enemy:init()
    sword:init()
    player:init()
    GUI:init()
    

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    map:update(dt)
    sword:update(dt)
    player:update(dt)
    GUI:update(dt)
    world:update(dt)
    enemy:update(dt)
    
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    map:draw()
    enemy:draw()
    sword:draw()
    player:draw()
    GUI:draw()
    --world:draw()

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
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

