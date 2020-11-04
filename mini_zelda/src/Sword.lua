Sword = Class{}

anim8 = require 'assets/libraries/anim8'

function Sword:init()
    Sword.sound = love.audio.newSource('assets/sounds/sword_sound.wav', 'stream')
    Sword.x = 0
    Sword.y = 0
    Sword.direction = "down"
    Sword.state = 'invisible'
    Sword.timer = 0
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
                Sword.state = 'invisible'
            end
        end
    end

end

function Sword:draw()
    love.graphics.setColor(1, 1, 1, 1)
    if Sword.state ~= 'invisible' then
        Sword.currentAnimation:draw(Sword.spriteSheet, Sword.x, Sword.y)
    end
end

function Sword:attack()
    if Sword.state ~= 'invisible' then        
        return false
    end
    Sword.x = px - 10
    Sword.y = py - 10
    Sword.sound:stop()
    Sword.sound:play()
    Sword.direction = Player.direction
    if Sword.direction == 'down' then
        Sword.currentAnimation = Sword.down
        --Sword.x = 
    elseif Sword.direction == 'left' then
        Sword.currentAnimation = Sword.left
    elseif Sword.direction == 'up' then
        Sword.currentAnimation = Sword.up
    elseif Sword.direction == 'right' then
        Sword.currentAnimation = Sword.right
    end

    Sword.state = 'attack'
    Sword.timer = 0.3
    return true
end