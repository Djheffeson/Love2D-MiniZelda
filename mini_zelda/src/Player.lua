Player = Class{}

anim8 = require 'assets/libraries/anim8'
WALK_SPEED = 70

function Player:init()

    Player.x = 100
    Player.y = 100

    -- Create a vector for collision
    Player.vectorX = 0
    Player.vectorY = 0

    Player.isMoving = false
    Player.state = 'walking'
    Player.direction = 'down'

    world:addCollisionClass('Player')

    Player.collider = world:newCircleCollider(Player.x, Player.y, 6)
    Player.collider:setCollisionClass('Player')
    Player.collider:setObject(Player)

    Player.health = 3
    
    -- Create the animation of the player
    Player.spritesheet = love.graphics.newImage('assets/graphics/player_sheet.png')
    walkGrid = anim8.newGrid(16, 16, Player.spritesheet:getWidth(), Player.spritesheet:getHeight())
    
    Player.walkDown = anim8.newAnimation(walkGrid('1-2', 1), 0.1)
    Player.walkRight = anim8.newAnimation(walkGrid('1-2', 2), 0.1)
    Player.walkLeft = anim8.newAnimation(walkGrid('1-2', 2), 0.1):flipH()
    Player.walkUp = anim8.newAnimation(walkGrid('1-2', 3), 0.1)

    Player.atackDown = anim8.newAnimation(walkGrid(2,1, 3,1, 2,1), {0.07, 0.3, 0.07}, attackComplete)
    Player.atackRight = anim8.newAnimation(walkGrid(2,2, 3,2, 2,2), {0.07, 0.3, 0.07}, attackComplete)
    Player.atackLeft = anim8.newAnimation(walkGrid(2,2, 3,2, 2,2), {0.07, 0.3, 0.07}, attackComplete):flipH()
    Player.atackUp = anim8.newAnimation(walkGrid(2,3, 3,3, 2,3), {0.07, 0.3, 0.07}, attackComplete)

    Player.currentAnimation = Player.walkDown

end

function Player:update(dt)
    if love.keyboard.wasPressed('f') and Sword.timer < 0 then
        Player:attack()
    end

    if Player.state == 'walking' then

        if Player.isMoving then
            Player.currentAnimation:update(dt)
        end

        Player.vectorX = 0
        Player.vectorY = 0

        px, py = Player.collider:getPosition()
        if love.keyboard.isDown('up') then
            Player.vectorY = -1
            Player.currentAnimation = Player.walkUp
            Player.direction = 'up'

        elseif love.keyboard.isDown('down') then
            Player.vectorY = 1
            Player.currentAnimation = Player.walkDown
            Player.direction = 'down'

        elseif love.keyboard.isDown('left') then
            Player.vectorX = -1
            Player.currentAnimation = Player.walkLeft
            Player.direction = 'left'

        elseif love.keyboard.isDown('right') then
            Player.vectorX = 1
            Player.currentAnimation = Player.walkRight
            Player.direction = 'right'
        end

        if Player.vectorX == 0 and Player.vectorY == 0 then
            Player.isMoving = false
        elseif not Player.isMoving then
            Player.isMoving = true
        end

        Player.collider:setLinearVelocity(Player.vectorX * WALK_SPEED, Player.vectorY * WALK_SPEED)
    
    elseif Player.state == 'attacking' then
        Player.currentAnimation:update(dt)
    end
    --print(px, py)
end

function Player:draw()
    -- Draw the animation
    Player.currentAnimation:draw(
        Player.spritesheet, px-9, py-10
    )
end

function Player:attack()
    if Player.state == 'walking' then
        Player.state = 'attacking'
        Player.collider:setLinearVelocity(0, 0)
        if Player.direction == 'up' then
            Player.currentAnimation = Player.atackUp
        elseif Player.direction == 'down' then
            Player.currentAnimation = Player.atackDown
        elseif Player.direction == 'left' then
            Player.currentAnimation = Player.atackLeft
        elseif Player.direction == 'right' then
            Player.currentAnimation = Player.atackRight
        end
        Sword.attack()
    end
end

function attackComplete()
    if Player.state == 'attacking' then
        Player.state = 'walking'
        if Player.direction == 'up' then
            Player.currentAnimation = Player.walkUp
        elseif Player.direction == 'down' then
            Player.currentAnimation = Player.walkDown
        elseif Player.direction == 'left' then
            Player.currentAnimation = Player.walkLeft
        elseif Player.direction == 'right' then
            Player.currentAnimation = Player.walkRight
        end
    end
end