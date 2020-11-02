Player = Class{}

require 'Util'

WALK_SPEED = 100

function Player:init()
    self.x = 50
    self.y = 50

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
        self.dy = 0
    end

    if love.keyboard.isDown('left') then
        self.dx = -WALK_SPEED * dt
    elseif love.keyboard.isDown('right') then
        self.dx = WALK_SPEED * dt
    else
        self.dx = 0
    end

    self.x = self.x + self.dx
    self.y = self.y + self.dy
end

function Player:render()
    love.graphics.draw(self.spritesheet, self.sprites[1], self.x, self.y)
end