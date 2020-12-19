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
    require 'src/swordThrow'
    require 'src/enemies'
    require 'src/items'
    require 'src/deathAnimation'
    require 'src/doors'
    require 'src/menu'
    require 'src/endGame'
    require 'src/writer'
    require 'src/NPCs'
    require 'src/fairies'
    require 'src/arrows'
    require 'src/minimap'

    map1 = Map()
    sword = Sword()
    player = Player()
    GUI = GUI()

    endGameStart()

    local shader_white = [[
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {

            vec4 pixel = Texel(texture, texture_coords);
            pixel.r = 1;
            pixel.g = 1;
            pixel.b = 1;
            return pixel;
        }
    ]]

    local shader_blackAndWhite = [[
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {

            vec4 pixel = Texel(texture, texture_coords);
            float avarage = (pixel.r + pixel.g + pixel.b) / 3;

            pixel.r = avarage;
            pixel.g = avarage;
            pixel.b = avarage;

            return pixel;
        }
    ]]

    white_flash = love.graphics.newShader(shader_white)
    blackAndWhiteShader = love.graphics.newShader(shader_blackAndWhite)

    loading = false
    loadingTimer = 0
    mapOverlap = false
end
