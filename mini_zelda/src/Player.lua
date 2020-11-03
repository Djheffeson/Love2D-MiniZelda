Player = Class{}

anim8 = require 'assets/libraries/anim8'

Player.isMoving = true
WALK_SPEED = 70

function Player:init()
    self.x = 100
    self.y = 100

    -- Create a vector for collision
    self.vectorX = 0
    self.vectorY = 0

    world:addCollisionClass('Player')

    self.collider = world:newCircleCollider(self.x, self.y, 6)
    self.collider:setCollisionClass('Player')
    self.collider:setObject(self)

    self.health = 3
    
    -- Create the animation of the player
    self.spritesheet = love.graphics.newImage('assets/graphics/player_sheet.png')
    walkGrid = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
    
    self.walkDown = anim8.newAnimation(walkGrid('1-2', 1), 0.1)
    self.walkRight = anim8.newAnimation(walkGrid('1-2', 2), 0.1)
    self.walkLeft = anim8.newAnimation(walkGrid('1-2', 2), 0.1):flipH()
    self.walkUp = anim8.newAnimation(walkGrid('1-2', 3), 0.1)
    self.atackDown = anim8.newAnimation(walkGrid(3, 1), 1)
    self.currentAnimation = self.walkDown

end

function Player:update(dt)
    px, py = self.collider:getPosition()
    if love.keyboard.isDown('up') then
        self.vectorY = -1
        self.currentAnimation = self.walkUp
    elseif love.keyboard.isDown('down') then
        self.vectorY = 1
        self.currentAnimation = self.walkDown

    elseif love.keyboard.isDown('left') then
        self.vectorX = -1
        self.currentAnimation = self.walkLeft

    elseif love.keyboard.isDown('right') then
        self.vectorX = 1
        self.currentAnimation = self.walkRight
        
    elseif love.keyboard.wasPressed('f') then
        Player:attack()
    end

    if player.isMoving then
        self.currentAnimation:update(dt)
    end

    self.collider:setLinearVelocity(self.vectorX * WALK_SPEED, self.vectorY * WALK_SPEED)

    self.vectorX = 0
    self.vectorY = 0

end

function Player:draw()
    -- Draw the animation
    self.currentAnimation:draw(
        self.spritesheet, px-9, py-10
    )
end

function Player:attack()
    animTmp = self.currentAnimation
    self.currentAnimation = self.atackDown
    if dt < 1/60 then
        love.timer.sleep(1 - dt)
    end
        self.currentAnimation = animTmp
end