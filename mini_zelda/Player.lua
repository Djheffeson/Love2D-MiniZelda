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

    self.spritesheet = love.graphics.newImage('graphics/player_sheet.png')
    self.sprites = generateQuads(self.spritesheet, 16, 16)
end

function Player:update(dt)
    if love.keyboard.isDown('up') then
        self.dy = -WALK_SPEED * dt
    elseif love.keyboard.isDown('down') then
        self.dy = WALK_SPEED * dt
    else
        if love.keyboard.isDown('left') then
            self.dx = -WALK_SPEED * dt
        elseif love.keyboard.isDown('right') then
            self.dx = WALK_SPEED * dt
        end
    end

    self.x = self.x + self.dx
    self.y = self.y + self.dy
    
    self.dx = 0
    self.dy = 0
end

function Player:draw()
    love.graphics.draw(self.spritesheet, self.sprites[1], self.x, self.y)
end