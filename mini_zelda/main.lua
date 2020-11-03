WINDOW_WIDTH = 256 * 3
WINDOW_HEIGHT = 224 * 3

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 224

Class = require 'class'

local push = require 'push'

require 'GUI'
require 'Map'
require 'Player'

function love.load()

    map = Map()
    player = Player()
    gui = GUI()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setFont(love.graphics.newFont('font/font.ttf', 16))
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,  {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
    
    map:init()
    player:init()
    GUI:init()
end

function love.update(dt)
    map:update(dt)
    player:update(dt)
    GUI:update(dt)
    world:update(dt)

end

function love.draw()
    push:start()
    
    map:draw()
    player:draw()
    GUI:draw()
    world:draw()

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
