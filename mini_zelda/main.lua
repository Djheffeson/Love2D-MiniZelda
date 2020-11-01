WINDOW_WIDTH = 1024
WINDOW_HEIGHT = 768

VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 240

local push = require "push"


function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.graphics.setFont(love.graphics.newFont('font/font.ttf', 16))

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,  {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
end

function love.update(dt)

end

function love.draw()
    push:start()
    love.graphics.print("Hello, World")
    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end