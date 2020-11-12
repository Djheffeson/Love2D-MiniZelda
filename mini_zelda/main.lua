function love.load()
    require 'src/startup/gameStart'
    gameStart()

    map:init()
    sword:init()
    GUI:init()
    enemies = {}
    for i=1, 4, 1 do
        table.insert(enemies, Enemy())
    end
    
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    map:update(dt)
    items:update(dt)
    sword:update(dt)
    player:update(dt)
    GUI:update(dt)
    world:update(dt)
    deaths:update(dt)
    for i, enemie in pairs(enemies) do
        if enemie.alive == false then
            table.remove(enemies, i)
        end
        enemie:update(dt)
    end

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    map:draw()
    items:draw()
    deaths:draw()
    for i, enemie in pairs(enemies) do
        enemie:draw()
    end
    sword:draw()
    player:draw()
    GUI:draw()
    world:draw() -- debug collisions

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    if key == 'v' then
        playerDamage(0.5)
    end
    if key == 'b' then
        playerHeal(0.5)
    end

    if key == '1' then
        changeRoom(room_1)
    end

    if key == '2' then
        changeRoom(room_2)
    end

    if key == '3' then
        changeRoom(room_3)
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

