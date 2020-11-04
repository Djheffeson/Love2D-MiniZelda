WINDOW_WIDTH = 256 * 3
WINDOW_HEIGHT = 224 * 3

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 224

Class = require 'assets/libraries/class'
local push = require 'assets/libraries/push'

require 'src/GUI'
require 'src/Map'
require 'src/Player'
require 'src/Sword'

map = Map()
player = Player()
gui = GUI()
sword = Sword()

function love.load()

    love.window.setTitle('Mini Zelda')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setFont(love.graphics.newFont('assets/font/font.ttf', 16))
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,  {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
    
    music = love.audio.newSource('assets/sounds/overworld.mp3', 'stream')
    music:setLooping(true)
    --music:play()

    map:init()
    player:init()
    GUI:init()
    sword:init()

    love.keyboard.keysPressed = {}
end

function love.update(dt)
    map:update(dt)
    player:update(dt)
    GUI:update(dt)
    world:update(dt)
    sword:update(dt)

    love.keyboard.keysPressed = {}

end

function love.draw()
    push:start()
    
    map:draw()
    player:draw()
    GUI:draw()
    --world:draw()
    sword:draw()

    push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end


function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

