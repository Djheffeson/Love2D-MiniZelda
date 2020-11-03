Player = Class{}

require 'Util'
anim8 = require 'anim8'

WALK_SPEED = 70

function Player:init()
    self.x = 100
    self.y = 100

    -- Create a vector for collision
    self.vectorX = 0
    self.vectorY = 0

    self.collider = world:newRectangleCollider(self.x, self.y, 8, 8)
    self.collider:setObject(self)
    
    self.health = 3
    
    -- Create the animation of the player
    self.spritesheet = love.graphics.newImage('graphics/player_sheet.png')
    walkGrid = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
    
    self.walkDown = anim8.newAnimation(walkGrid('1-2', 1), 0.1)
    self.walkRight = anim8.newAnimation(walkGrid('1-2', 2), 0.1)
    self.walkLeft = anim8.newAnimation(walkGrid('1-2', 2), 0.1):flipH()
    self.walkUp = anim8.newAnimation(walkGrid('1-2', 3), 0.1)
    self.currentAnimation = self.walkDown

end

function Player:update(dt)
    px, py = self.collider:getPosition()
    if love.keyboard.isDown('up') then
        self.vectorY = -1

        self.currentAnimation = self.walkUp
        self.walkUp:update(dt)
    elseif love.keyboard.isDown('down') then
        self.vectorY = 1

        self.currentAnimation = self.walkDown
        self.walkDown:update(dt)
    else
        if love.keyboard.isDown('left') then
            self.vectorX = -1

            self.currentAnimation = self.walkLeft
            self.walkLeft:update(dt)
        elseif love.keyboard.isDown('right') then
            self.vectorX = 1

            self.currentAnimation = self.walkRight
            self.walkRight:update(dt)
        end
    end

    self.collider:setLinearVelocity(self.vectorX * WALK_SPEED, self.vectorY * WALK_SPEED)

    self.vectorX = 0
    self.vectorY = 0

end

function Player:draw()
    -- Draw the animation
    self.currentAnimation:draw(
        self.spritesheet, px-9, py-12
    )
end