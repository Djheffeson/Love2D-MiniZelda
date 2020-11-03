Map = Class{}

local sti = require 'assets/libraries/sti'

windfield = require 'assets/libraries/windfield'

function Map:init()
    map = sti('assets/tilemaps/testmap.lua', { 'box2d' })
    world = windfield.newWorld()
    --world1 = love.physics.newWorld(0, 0)
    --map:box2d_init(world1)
    --map:box2d_draw(world ,100, 200, 10, 10)
    testWall = world:newRectangleCollider(48, 130, 16, 16)
    testWall:setType('static')
end

function Map:update(dt)

end

function Map:draw()
end
