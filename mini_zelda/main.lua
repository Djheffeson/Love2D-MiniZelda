WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 768

VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 240

Class = require 'class'

local push = require 'push'
local sti = require "sti"

require 'Player'

player = Player()

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.graphics.setFont(love.graphics.newFont('font/font.ttf', 16))

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,  {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    map = sti('tilemaps/testmap.lua')

    player:init()
end

function love.update(dt)
    player:update(dt)
    map:update(dt)
end

function love.draw()
    push:start()

    player:render()
    map:render()

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end