function love.load()
    
    require 'src/startup/gameStart'
    gameStart()

    love.keyboard.keysPressed = {}
end

function love.update(dt)

    -- check if the game is "loading"
    if loading then
        loadingTimer = loadingTimer + 1 * dt
        if loadingTimer < 0.5 then
            loading = true
            return
        else
            loading = false
            loadingTimer = 0
        end
    end

    map:update(dt)
    map1:update(dt)
    items:update(dt)
    sword:update(dt)
    player:update(dt)
    NPCs:update(dt)
    GUI:update(dt)
    world:update(dt)
    deaths:update(dt)
    enemies:update(dt)
    doors:update(dt)
    menu:update(dt)
    endGame:update(dt)
    writer:update(dt)
    fairies:update(dt)

    love.keyboard.keysPressed = {}

end

function love.draw()

    push:start()

    map1:draw()
    doors:draw()
    items:draw()
    deaths:draw()
    enemies:draw()
    fairies:draw()
    NPCs:draw()
    sword:draw()
    player:draw()
    swordThrow:draw()
    menu:draw()
    endGame:draw()
    --world:draw() -- debug collisions

    if Player.grabbed == true then
        enemies:draw()
    end

    if Map.type == 'dungeon_1' and gameState ~= 'game_over' and gameState ~= 'menu_continue' and gameState ~= 'shardCollected' and gameState ~= 'death' then
        Map:drawDungeonWalls()
    end

    GUI:draw()

    if mapOverlap then
        map1:draw()
    end

    -- draw a black rectangle for loading
    if loading then
        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(1,1,1,1)
    end

    writer:draw()

    push:finish()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end
