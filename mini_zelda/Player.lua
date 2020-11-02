Player = Class{}

require 'Util'
anim8 = require 'anim8'

WALK_SPEED = 70

function Player:init()
    self.x = 100
    self.y = 100

    self.dx = 0
    self.dy = 0

    self.health = 3
    
    -- Create the animation of the player
    self.spritesheet = love.graphics.newImage('graphics/player_sheet.png')
    walkGrid = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
    self.walkDown = anim8.newAnimation(walkGrid('1-2', 1), 0.1)
    self.walkRight = anim8.newAnimation(walkGrid('1-2', 2), 0.1)
    self.walkLeft = anim8.newAnimation(walkGrid('1-2', 2), 0.1):flipH()
    self.walkUp = anim8.newAnimation(walkGrid('1-2', 3), 0.1)
    self.actualAnimation = self.walkDown

end

function Player:update(dt)
    if love.keyboard.isDown('up') then
        self.dy = -WALK_SPEED * dt
        self.actualAnimation = self.walkUp
        self.walkUp:update(dt)
    elseif love.keyboard.isDown('down') then
        self.dy = WALK_SPEED * dt
        self.actualAnimation = self.walkDown
        self.walkDown:update(dt)
    else
        if love.keyboard.isDown('left') then
            self.dx = -WALK_SPEED * dt
            self.actualAnimation = self.walkLeft
            self.walkLeft:update(dt)
        elseif love.keyboard.isDown('right') then
            self.dx = WALK_SPEED * dt
            self.actualAnimation = self.walkRight
            self.walkRight:update(dt)
        end
    end
    
    self.x = self.x + self.dx
    self.y = self.y + self.dy
    
    self.dx = 0
    self.dy = 0

end

function Player:draw()
    -- Draw the animation
    self.actualAnimation:draw(
        self.spritesheet, player.x, player.y
    )
end