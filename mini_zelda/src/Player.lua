Player = Class{}

anim8 = require 'assets/libraries/anim8'
PLAYER_WIDTH = 16
PLAYER_HEIGHT = 16
WALK_SPEED = 80

function Player:init()

    Player.x = 100
    Player.y = 100

    -- Create a vector for collision
    Player.vectorX = 0
    Player.vectorY = 0

    Player.isMoving = false
    Player.state = 'walking'
    Player.direction = 'up'
    Player.invincible = false
    Player.recive_damage = false

    Player.max_hearts = 3
    Player.hearts = Player.max_hearts

    Player.collider = world:newCircleCollider(Player.x, Player.y, 6)
    Player.collider:setCollisionClass('Player')
    Player.collider:setObject(Player)
    
    -- Create the animation of the player
    walkGrid = anim8.newGrid(PLAYER_WIDTH, PLAYER_HEIGHT, 
        sprites.linkSheet:getWidth(), sprites.linkSheet:getHeight())
    
    Player.walkDown = anim8.newAnimation(walkGrid('1-2', 1), 0.1)
    Player.walkRight = anim8.newAnimation(walkGrid('1-2', 2), 0.1)
    Player.walkLeft = anim8.newAnimation(walkGrid('1-2', 2), 0.1):flipH()
    Player.walkUp = anim8.newAnimation(walkGrid('1-2', 3), 0.1)
    Player.currentAnimation = Player.walkUp

    Player.atackDown = anim8.newAnimation(walkGrid(3,1, 3,1, 3,1), {0.07, 0.077, 0.07}, attackComplete)
    Player.atackRight = anim8.newAnimation(walkGrid(3,2, 3,2, 3,2), {0.07, 0.077, 0.07}, attackComplete)
    Player.atackLeft = anim8.newAnimation(walkGrid(3,2, 3,2, 3,2), {0.07, 0.077, 0.07}, attackComplete):flipH()
    Player.atackUp = anim8.newAnimation(walkGrid(3,3, 3,3, 3,3), {0.07, 0.077, 0.07}, attackComplete)

    Player.timer = 0
end

function Player:update(dt)

    if Player.recive_damage then
        Player.invincible = true
        Player.recive_damage = false
        Player.state = 'pushed'
        damage_timer = 0
    end
    if Player.invincible then
        Player.timer = Player.timer + 1 * dt
    end
    
    if Player.timer >= 0.750 then
        Player.timer = 0
        if Player.invincible then
            Player.invincible = false
        end
    end
    
    if Player.hearts <= 0 then
        print("YOU DIE")
        return
    end

    if Player.hearts > Player.max_hearts then
        Player.hearts = Player.max_hearts
    end
    
    if love.keyboard.wasPressed('f') and Sword.timer < 0 and Player.state == 'walking' then
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

    elseif Player.state == 'pushed' then
        px, py = Player.collider:getPosition()
        
        -- link is pushed
        local v1, v2 = ((getDirectionVector(Player.direction):rotateInplace(math.pi)) * dt * 300):unpack()
        Player.collider:setLinearVelocity(v1 * WALK_SPEED, v2 * WALK_SPEED)
        damage_timer = damage_timer + 1 * dt
        if damage_timer >= 0.133 then
            damage_timer = 0
            Player.state = 'walking'
        end
    end
end

function Player:draw()
    if Player.invincible then
        love.graphics.setColor(1, 0, 0, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    -- Draw the animation
    Player.currentAnimation:draw(
        sprites.linkSheet, px-9, py-10
    )
    love.graphics.setColor(1, 1, 1, 1)
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

function playerDamage(value)
    if Player.invincible == false then
        Player.hearts = player.hearts - value
        Player.recive_damage = true
    end
end

function playerHeal(value)
    Player.hearts = player.hearts + value
end
