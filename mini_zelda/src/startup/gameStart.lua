function gameStart()
    WINDOW_WIDTH = 768
    WINDOW_HEIGHT = 672
    
    VIRTUAL_WIDTH = 768 / 3
    VIRTUAL_HEIGHT = 672 / 3

    gameState = 'running'

    Class = require 'assets/libraries/hump/class'
    push = require 'assets/libraries/push'
    anim8 = require 'assets/libraries/anim8'
    sti = require 'assets/libraries/sti'
    vector = require 'assets/libraries/hump/vector'
    windfield = require 'assets/libraries/windfield'

    love.window.setTitle('Mini Zelda')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setFont(love.graphics.newFont('assets/font/font.ttf', 8))
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,  {
        fullscreen = false,
        vsync = true,
        resizable = false
    })

    world = windfield.newWorld()

    require 'src/startup/collisionClasses'
    require 'src/startup/resources'
    require 'src/Util'
    require 'src/GUI'
    require 'src/Map'
    require 'src/Player'
    require 'src/Sword'
    require 'src/enemies'
    require 'src/items'
    require 'src/deathAnimation'

    map1 = Map()
    sword = Sword()
    player = Player()
    GUI = GUI()
end
