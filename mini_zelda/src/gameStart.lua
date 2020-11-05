function gameStart()
    WINDOW_WIDTH = 256 * 3
    WINDOW_HEIGHT = 224 * 3

    VIRTUAL_WIDTH = 256
    VIRTUAL_HEIGHT = 224
    
    Class = require 'assets/libraries/hump/class'
    push = require 'assets/libraries/push'
    anim8 = require 'assets/libraries/anim8'
    sti = require 'assets/libraries/sti'
    vector = require 'assets/libraries/hump/vector'

    require 'src/GUI'
    require 'src/Map'
    require 'src/Player'
    require 'src/Sword'
    require 'src/Enemy'
    
    map = Map()
    sword = Sword()
    player = Player()
    GUI = GUI()
    enemy = Enemy()

    love.window.setTitle('Mini Zelda')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setFont(love.graphics.newFont('assets/font/font.ttf', 16))
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,  {
        fullscreen = false,
        vsync = true,
        resizable = false
    })
end