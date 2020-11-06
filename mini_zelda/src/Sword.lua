Sword = Class{}

function Sword:init()
    Sword.sound = love.audio.newSource('assets/sounds/sword_sound.wav', 'stream')
    Sword.x = 0
    Sword.y = 0
    Sword.direction = "down"
    Sword.directionVector = vector(0, 1) -- down
    Sword.state = 'invisible'
    Sword.timer = -1

    Sword.spriteSheet = love.graphics.newImage('assets/graphics/wooden_sword_sheet.png')
    Sword.grid = anim8.newGrid(16, 16, Sword.spriteSheet:getWidth(), Sword.spriteSheet:getHeight())

    Sword.down = anim8.newAnimation(Sword.grid(1, 1), 1)
    Sword.left = anim8.newAnimation(Sword.grid(2, 1), 1)
    Sword.up = anim8.newAnimation(Sword.grid(3, 1), 1)
    Sword.right = anim8.newAnimation(Sword.grid(4, 1), 1)

    Sword.currentAnimation = Sword.up

end

function Sword:update(dt)

    if Sword.timer > 0 then
        Sword.timer = Sword.timer - dt
        if Sword.timer < 0 then
            if Sword.state == 'attack' then
                Sword.state = 'pause'
                Sword.timer = 0.077
            elseif Sword.state == 'pause' then
                Sword.timer = 0.07
                Sword.directionVector:rotateInplace(math.pi)
                Sword.state = 'back'
            else
                Sword.state = 'invisible'
            end
        end
    end

    if Sword.state == 'back' then
        local dx, dy = (Sword.directionVector * dt * 105):unpack()
        Sword.x =  Sword.x + dx
        Sword.y =  Sword.y + dy
    end
end

function Sword:draw()

    if Sword.state ~= 'invisible' then
        love.graphics.setColor(1, 1, 1, 1)
        Sword.currentAnimation:draw(Sword.spriteSheet, Sword.x, Sword.y)
    end
end

function Sword:attack()
    
    if Sword.state ~= 'invisible' then        
        return
    end
    Sword.sound:stop()
    Sword.sound:play()
    -- Sword.x recive the same position of the player
    Sword.x = px - 10
    Sword.y = py - 10
    Sword.direction = Player.direction
    Sword.directionVector = getDirectionVector(Sword.direction)

    if Sword.direction == 'down' then
        Sword.currentAnimation = Sword.down

        Sword.x = Sword.x + 1
        Sword.y = Sword.y + 12
    elseif Sword.direction == 'left' then
        Sword.currentAnimation = Sword.left

        Sword.x = Sword.x - 11
        Sword.y = Sword.y + 1
    elseif Sword.direction == 'up' then
        Sword.currentAnimation = Sword.up

        Sword.x = Sword.x - 1
        Sword.y = Sword.y - 12
    elseif Sword.direction == 'right' then
        Sword.currentAnimation = Sword.right

        Sword.x = Sword.x + 13
        Sword.y = Sword.y + 1
    end

    Sword.state = 'attack'
    Sword.timer = 0.07
end
